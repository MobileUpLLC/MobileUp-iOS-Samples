enum SignInPhoneFactory {
    static func createSignInPhoneController() -> SignInPhoneController {
        let coordinator = SignInPhoneCoordinator()
        let authRepository = AuthRepository()
        let viewModel = SignInPhoneViewModel(coordinator: coordinator, authRepository: authRepository)
        let controller = SignInPhoneController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
