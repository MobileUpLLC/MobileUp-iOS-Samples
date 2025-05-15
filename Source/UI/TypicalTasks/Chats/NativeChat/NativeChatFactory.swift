enum NativeChatFactory {
    static func createNativeChatController(networkService: NetworkService) -> NativeChatController {
        let coordinator = NativeChatCoordinator()
        let chatRepository = ChatRepository(networkService: networkService)
        let webSocketNativeService = WebSocketNativeService()
        let viewModel = NativeChatViewModel(
            coordinator: coordinator,
            chatRepository: chatRepository,
            webSocketNativeService: webSocketNativeService
        )
        let controller = NativeChatController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
