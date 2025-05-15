enum ChatsFactory {
    static func createChatsController(networkService: NetworkService) -> ChatsController {
        let coordinator = ChatsCoordinator()
        let chatRepository = ChatRepository(networkService: networkService)
        let webSocketNativeService = WebSocketNativeService()
        let viewModel = ChatsViewModel(
            coordinator: coordinator,
            chatRepository: chatRepository,
            webSocketNativeService: webSocketNativeService
        )
        let controller = ChatsController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
