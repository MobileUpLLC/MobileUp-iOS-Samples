enum ChatsFactory {
    static func createChatsController(networkService: NetworkService) -> ChatsController {
        let coordinator = ChatsCoordinator(networkService: networkService)
//        let chatRepository = ChatRepository(networkService: networkService)
        let viewModel = ChatsViewModel(coordinator: coordinator)
        let controller = ChatsController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
