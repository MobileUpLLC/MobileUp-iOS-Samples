enum NavigationExampleFactory {
    static func createNavigationExampleController() -> NavigationExampleController {
        let coordinator = NavigationExampleCoordinator()
        let navigationRepository = NavigationRepository()
        let viewModel = NavigationExampleViewModel(coordinator: coordinator, navigationRepository: navigationRepository)
        let controller = NavigationExampleController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
