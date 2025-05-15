import Foundation

final class StarscreamChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var messageText: String = ""
    
    private let coordinator: StarscreamChatCoordinator
    private let chatRepository: ChatRepository
    
    init(coordinator: StarscreamChatCoordinator, chatRepository: ChatRepository) {
        self.coordinator = coordinator
        self.chatRepository = chatRepository
    }
}
