enum AuthorizationFactory {
    static func createAuthorizationController(networkService: NetworkService) -> AuthorizationController {
        let coordinator = AuthorizationCoordinator(networkService: networkService)
        let authRepository = AuthRepository(networkService: networkService)
        let viewModel = AuthorizationViewModel(coordinator: coordinator, authRepository: authRepository)
        
        let controller = AuthorizationController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
