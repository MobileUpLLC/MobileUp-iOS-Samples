enum NavigationFactory {
    static func createNavigationController() -> NavigationController {
        let coordinator = NavigationCoordinator()
        let navigationRepository = NavigationRepository()
        let viewModel = NavigationViewModel(coordinator: coordinator, navigationRepository: navigationRepository)
        let controller = NavigationController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
