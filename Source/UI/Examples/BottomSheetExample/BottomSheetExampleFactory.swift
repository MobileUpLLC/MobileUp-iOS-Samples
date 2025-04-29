enum BottomSheetExampleFactory {
    static func createBottomSheetExampleController(
        networkService: NetworkService
    ) -> BottomSheetExampleController {
        let coordinator = BottomSheetExampleCoordinator(networkService: networkService)
        let viewModel = BottomSheetExampleViewModel(coordinator: coordinator)
        let controller = BottomSheetExampleController(viewModel: viewModel)
        coordinator.router = controller

        return controller
    }
}
