enum ComplexUIComponentsFactory {
    static func createComplexUIComponentsController() -> ComplexUIComponentsController {
        let coordinator = ComplexUIComponentsCoordinator()
        let viewModel = ComplexUIComponentsViewModel(coordinator: coordinator)
        let controller = ComplexUIComponentsController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
