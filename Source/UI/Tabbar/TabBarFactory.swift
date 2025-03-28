enum TabBarFactory {
    static func createTabbarController() -> CustomTabBarController {
        let examplesController = ExamplesFactory.createExamplesController()
        let bottomSheetController = BottomSheetExampleFactory.createBottomSheetExampleController()
        
        let coordinator = TabBarCoordinator()
        let viewModel = TabbarViewModel(coordinator: coordinator, pushService: .shared, mobileService: .shared)
        let controller = CustomTabBarController(
            viewModel: viewModel,
            controllers: [examplesController, bottomSheetController]
        )
        coordinator.router = controller

        return controller
    }
}
