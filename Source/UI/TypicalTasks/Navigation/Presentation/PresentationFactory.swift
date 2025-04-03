enum PresentationFactory {
    static func createPresentationController() -> PresentationController {
        let coordinator = PresentationCoordinator()
        let viewModel = PresentationViewModel(coordinator: coordinator)
        let controller = PresentationController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
