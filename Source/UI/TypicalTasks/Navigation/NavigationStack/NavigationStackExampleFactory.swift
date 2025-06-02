enum NavigationStackExampleFactory {
    static func createNavigationStackExampleController() -> NavigationStackExampleController {
        let coordinator = NavigationStackExampleCoordinator()
        let viewModel = NavigationStackExampleViewModel(coordinator: coordinator)
        let controller = NavigationStackExampleController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
