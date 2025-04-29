import munkit

enum LaunchFactory {
    static func createLaunchController(networkService: NetworkService) async -> LaunchController {
        let coordinator = LaunchCoordinator()
        let viewModel = LaunchViewModel(coordinator: coordinator, networkService: networkService)
        let controller = await LaunchController(viewModel: viewModel)
        coordinator.router = controller

        return controller
    }
}
