enum LaunchFactory {
    static func createLaunchController() -> LaunchController {
        let coordinator = LaunchCoordinator()
        let viewModel = LaunchViewModel(coordinator: coordinator)
        let controller = LaunchController(viewModel: viewModel)
        coordinator.router = controller

        return controller
    }
}
