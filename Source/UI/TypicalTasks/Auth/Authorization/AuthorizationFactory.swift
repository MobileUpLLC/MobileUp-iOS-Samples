enum AuthorizationFactory {
    static func createAuthorizationController() -> AuthorizationController {
        let coordinator = AuthorizationCoordinator()
        let authRepository = AuthRepository()
        let viewModel = AuthorizationViewModel(coordinator: coordinator, authRepository: authRepository)
        
        let controller = AuthorizationController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
