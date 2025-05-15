enum ChatsFactory {
    static func createChatsController(networkService: NetworkService) -> ChatsController {
        let coordinator = ChatsCoordinator()
        let chatRepository = ChatRepository(networkService: networkService)
        let viewModel = ChatsViewModel(coordinator: coordinator, chatRepository: chatRepository)
        let controller = ChatsController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
