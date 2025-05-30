enum TabBarFactory {
    @MainActor static func createTabbarController(networkService: NetworkService) async -> CustomTabBarController {
        let typicalTasksController = TypicalTasksFactory.createTypicalTasksController(networkService: networkService)
        let examplesController = ExamplesFactory.createExamplesController(networkService: networkService)
        let bottomSheetController = BottomSheetExampleFactory.createBottomSheetNavigationContriller(
            networkService: networkService
        )

        let coordinator = TabBarCoordinator(networkService: networkService)
        let viewModel = TabbarViewModel(coordinator: coordinator, pushService: .shared, networkService: networkService)
        let controller = CustomTabBarController(
            viewModel: viewModel,
            controllers: [typicalTasksController, examplesController, bottomSheetController]
        )
        coordinator.router = controller
        
        await networkService.setAuthorizationObjects(
            provider: AuthRepository(networkService: networkService),
            refresher: AuthRepository(networkService: networkService),
            tokenRefreshFailureHandler: { await coordinator.openLaunch() }
        )
        
        return controller
    }
}
