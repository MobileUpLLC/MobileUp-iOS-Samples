enum NativeChatFactory {
    static func createNativeChatController(networkService: NetworkService) -> NativeChatController {
        let coordinator = NativeChatCoordinator()
        let chatRepository = ChatRepository(networkService: networkService)
        let nativeWebSocketService = NativeWebSocketService()
        let viewModel = NativeChatViewModel(
            coordinator: coordinator,
            chatRepository: chatRepository,
            nativeWebSocketService: nativeWebSocketService
        )
        let controller = NativeChatController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
