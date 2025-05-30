enum ComplexUIComponentsFactory {
    static func createComplexUIComponentsController(networkService: NetworkService) -> ComplexUIComponentsController {
        let coordinator = ComplexUIComponentsCoordinator(networkService: networkService)
        let viewModel = ComplexUIComponentsViewModel(coordinator: coordinator)
        let controller = ComplexUIComponentsController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
