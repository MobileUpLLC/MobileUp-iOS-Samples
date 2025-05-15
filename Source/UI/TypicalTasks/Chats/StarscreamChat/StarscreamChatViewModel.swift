import Foundation

final class StarscreamChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var messageText: String = ""
    @Published var isLoading: Bool = true
    
    private let coordinator: StarscreamChatCoordinator
    private let chatRepository: ChatRepository
    private let starscreamWebSocketService: StarscreamWebSocketService
    
    private let chatId = "1"
    
    init(
        coordinator: StarscreamChatCoordinator,
        chatRepository: ChatRepository,
        starscreamWebSocketService: StarscreamWebSocketService
    ) {
        self.coordinator = coordinator
        self.chatRepository = chatRepository
        self.starscreamWebSocketService = starscreamWebSocketService
    }
    
    deinit { disconnect() }
    
    func handleFirstAppear() {
        getMessages()
        connect()
    }
    
    func handleSendMessageButtonTap() {
        sendMessage()
    }
    
    func connect() {
        starscreamWebSocketService.onMessageReceived = { [weak self] text in
            let message = Message(
                id: UUID().uuidString,
                text: text,
                timestamp: Date().timeIntervalSince1970,
                senderId: "echo"
            )
            self?.messages.append(message)
        }
        
        Task {
            try await starscreamWebSocketService.connect()
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
            try await starscreamWebSocketService.sendMessage(messageText)
        }
        
        messages.append(message)
        messageText = ""
    }
    
    private func getMessages() {
        Task {
            do {
                let fetchedMessages = try await chatRepository.getMessages(chatId: chatId)
                
                await MainActor.run {
                    messages.append(contentsOf: fetchedMessages)
                    isLoading = false
                }
            } catch {
                print("Error fetching messages: \(error)")
            }
        }
    }
    
    private func disconnect() {
        starscreamWebSocketService.disconnect()
    }
}
