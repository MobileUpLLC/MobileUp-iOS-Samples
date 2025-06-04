enum TransparentPresentationExampleFactory {
    static func createTransparentPresentationExampleController() -> TransparentPresentationExampleController {
        let coordinator = TransparentPresentationExampleCoordinator()
        let viewModel = TransparentPresentationExampleViewModel(coordinator: coordinator)
        let controller = TransparentPresentationExampleController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
