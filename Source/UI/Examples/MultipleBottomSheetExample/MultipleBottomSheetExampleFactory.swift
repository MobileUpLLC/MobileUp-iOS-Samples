enum MultipleBottomSheetExampleFactory {
    static func createMultipleBottomSheetExampleController() -> MultipleBottomSheetExampleController {
        let coordinator = MultipleBottomSheetExampleCoordinator()
        let viewModel = MultipleBottomSheetExampleViewModel(coordinator: coordinator)
        let controller = MultipleBottomSheetExampleController(viewModel: viewModel)
        coordinator.router = controller

        return controller
    }
}
