enum SignInPhoneFactory {
    static func createSignInPhoneController(networkService: NetworkService) -> SignInPhoneController {
        let coordinator = SignInPhoneCoordinator(networkService: networkService)
        let authRepository = AuthRepository(networkService: networkService)
        let viewModel = SignInPhoneViewModel(coordinator: coordinator, authRepository: authRepository)
        let controller = SignInPhoneController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
