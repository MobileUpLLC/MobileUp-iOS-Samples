enum NavigationStackFactory {    
    static func createNavigationStackController() -> NavigationStackController {
        let coordinator = NavigationStackCoordinator()
        let viewModel = NavigationStackViewModel(coordinator: coordinator)
        let controller = NavigationStackController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
