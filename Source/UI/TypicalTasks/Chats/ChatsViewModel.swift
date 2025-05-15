import Foundation

final class ChatsViewModel: ObservableObject {
    private let coordinator: ChatsCoordinator
    private let chatRepository: ChatRepository
    private var messages: [Message] = []
    
    init(coordinator: ChatsCoordinator, chatRepository: ChatRepository) {
        self.coordinator = coordinator
        self.chatRepository = chatRepository
        
        getMessages()
    }
    
    private func getMessages() {
        Task {
            do {
                messages = try await chatRepository.getMessages(chatId: "1")
                print(messages)
            } catch {
                print("Error fetching messages: \(error)")
            }
        }
    }
}
