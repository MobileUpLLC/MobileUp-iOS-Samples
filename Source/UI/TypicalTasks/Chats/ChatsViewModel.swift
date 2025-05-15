import Foundation

final class ChatsViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var messageText: String = ""
    
    private let coordinator: ChatsCoordinator
    private let chatRepository: ChatRepository
    private let webSocketNativeService: WebSocketNativeService
    
    private let chatId = "1"
    
    init(
        coordinator: ChatsCoordinator,
        chatRepository: ChatRepository,
        webSocketNativeService: WebSocketNativeService
    ) {
        self.coordinator = coordinator
        self.chatRepository = chatRepository
        self.webSocketNativeService = webSocketNativeService
    }
    
    deinit { disconnect() }
    
    func handleFirstAppear() {
        getMessages()
        connect()
    }
    
    func handleSendMessageButtonTap() {
        sendMessage()
    }
    
    private func connect() {
        webSocketNativeService.onMessageReceived = { [weak self] text in
            Task { @MainActor in
                let message = Message(
                    id: UUID().uuidString,
                    text: text,
                    timestamp: Date().timeIntervalSince1970,
                    senderId: "echo"
                )
                self?.messages.append(message)
            }
        }
        
        Task {
            try await webSocketNativeService.connect()
        }
    }
    
    private func sendMessage() {
        guard messageText.isEmpty == false else {
            return
        }
        
        let message = Message(
            id: UUID().uuidString,
            text: messageText,
            timestamp: Date().timeIntervalSince1970,
            senderId: "user"
        )
        
        Task {
            try await webSocketNativeService.sendMessage(message.text)
        }
        
        messages.append(message)
        messageText = String.empty
    }
    
    private func disconnect() {
        webSocketNativeService.disconnect()
    }
    
    private func getMessages() {
        Task {
            do {
                let fetchedMessages = try await chatRepository.getMessages(chatId: chatId)
                
                await MainActor.run {
                    messages.append(contentsOf: fetchedMessages)
                }
            } catch {
                print("Error fetching messages: \(error)")
            }
        }
    }
}
