enum StarscreamChatFactory {
    static func createStarscreamChatController(networkService: NetworkService) -> StarscreamChatController {
        let coordinator = StarscreamChatCoordinator()
        let chatRepository = ChatRepository(networkService: networkService)
        let viewModel = StarscreamChatViewModel(
            coordinator: coordinator,
            chatRepository: chatRepository
        )
        let controller = StarscreamChatController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
