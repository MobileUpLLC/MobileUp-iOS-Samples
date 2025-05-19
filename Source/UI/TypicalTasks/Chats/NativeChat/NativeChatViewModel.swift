import Foundation

final class NativeChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var messageText: String = ""
    @Published var isLoading: Bool = true
    
    private let coordinator: NativeChatCoordinator
    private let chatRepository: ChatRepository
    private let nativeWebSocketService: NativeWebSocketService
    
    private let chatId = "1"
    
    init(
        coordinator: NativeChatCoordinator,
        chatRepository: ChatRepository,
        nativeWebSocketService: NativeWebSocketService
    ) {
        self.coordinator = coordinator
        self.chatRepository = chatRepository
        self.nativeWebSocketService = nativeWebSocketService
    }
    
    func handleFirstAppear() {
        getMessages()
        connect()
    }
    
    func handleSendMessageButtonTap() {
        sendMessage()
    }
    
    private func connect() {
        nativeWebSocketService.onMessageReceived = { [weak self] text in
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
            try await nativeWebSocketService.connect()
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
            try await nativeWebSocketService.sendMessage(message.text)
        }
        
        messages.append(message)
        messageText = String.empty
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
}
