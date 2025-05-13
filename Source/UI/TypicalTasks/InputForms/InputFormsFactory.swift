enum InputFormsFactory {
    static func createInputFormsController() -> InputFormsController {
        let coordinator = InputFormsCoordinator()
        let viewModel = InputFormsViewModel(coordinator: coordinator)
        let controller = InputFormsController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
