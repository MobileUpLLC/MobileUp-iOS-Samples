import UIKit

enum TypicalTabBarFactory {
    static func createTypicalTabBarController() -> TypicalCustomTabBarController {
        let typicalTabBarFirstExampleController = TypicalTabBarFirstExampleFactory
            .createTypicalTabBarFirstExampleController()
        let typicalTabBarSecondExampleController = TypicalTabBarSecondExampleFactory
            .createTypicalTabBarSecondExampleController()
        
        let coordinator = TabBarCoordinator()
        let viewModel = TypicalTabBarViewModel(coordinator: coordinator)
        let controller = TypicalCustomTabBarController(
            viewModel: viewModel,
            controllers: [typicalTabBarFirstExampleController, typicalTabBarSecondExampleController]
        )
        coordinator.router = controller

        return controller
    }
}
