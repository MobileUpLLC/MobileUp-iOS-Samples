enum BottomSheetExampleFactory {
    static func createBottomSheetExampleController() -> BottomSheetExampleController {
        let coordinator = BottomSheetExampleCoordinator()
        let viewModel = BottomSheetExampleViewModel(coordinator: coordinator)
        let controller = BottomSheetExampleController(viewModel: viewModel)
        coordinator.router = controller

        return controller
    }
}
