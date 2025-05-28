enum BottomSheetExampleFactory {
    static func createBottomSheetExampleController() -> BottomSheetExampleController {
        let coordinator = BottomSheetExampleCoordinator()
        let authRepository = AuthRepository()
        let viewModel = BottomSheetExampleViewModel(coordinator: coordinator, authRepository: authRepository)
        let controller = BottomSheetExampleController(viewModel: viewModel)
        coordinator.router = controller

        return controller
    }
}
