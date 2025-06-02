enum PresentationExampleFactory {
    static func createPresentationExampleController() -> PresentationExampleController {
        let coordinator = PresentationExampleCoordinator()
        let viewModel = PresentationExampleViewModel(coordinator: coordinator)
        let controller = PresentationExampleController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
