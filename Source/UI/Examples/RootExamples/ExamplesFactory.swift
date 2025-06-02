enum ExamplesFactory {
    static func createExamplesController(networkService: NetworkService) -> NavigationController {
        let coordinator = ExamplesCoordinator(networkService: networkService)
        let viewModel = ExamplesViewModel(coordinator: coordinator)
        let controller = ExamplesController(viewModel: viewModel)
        coordinator.router = controller
        
        return NavigationController(rootViewController: controller)
    }
}
