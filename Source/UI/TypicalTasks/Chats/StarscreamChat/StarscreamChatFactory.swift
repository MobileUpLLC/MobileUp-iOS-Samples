enum StarscreamChatFactory {
    static func createStarscreamChatController(networkService: NetworkService) -> StarscreamChatController {
        let coordinator = StarscreamChatCoordinator()
        let chatRepository = ChatRepository(networkService: networkService)
        let starscreamWebSocketService = StarscreamWebSocketService()
        let viewModel = StarscreamChatViewModel(
            coordinator: coordinator,
            chatRepository: chatRepository,
            starscreamWebSocketService: starscreamWebSocketService
        )
        let controller = StarscreamChatController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
