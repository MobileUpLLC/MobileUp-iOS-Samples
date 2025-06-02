import munkit

enum LaunchFactory {
    @MainActor static func createLaunchController(networkService: NetworkService) async -> LaunchController {
        let coordinator = LaunchCoordinator()
        let viewModel = LaunchViewModel(coordinator: coordinator, networkService: networkService)
        let controller = LaunchController(viewModel: viewModel)
        coordinator.router = controller

        return controller
    }
}
