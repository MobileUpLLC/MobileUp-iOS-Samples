enum BottomSheetWithScrollExampleFactory {
    static func createBottomSheetWithScrollExampleController() -> BottomSheetWithScrollExampleController {
        let coordinator = BottomSheetWithScrollExampleCoordinator()
        let viewModel = BottomSheetWithScrollExampleViewModel(coordinator: coordinator)
        let controller = BottomSheetWithScrollExampleController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
