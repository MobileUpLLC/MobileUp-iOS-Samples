enum TransparentPresentationFactory {
    static func createTransparentPresentationController() -> TransparentPresentationController {
        let coordinator = TransparentPresentationCoordinator()
        let viewModel = TransparentPresentationViewModel(coordinator: coordinator)
        let controller = TransparentPresentationController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
