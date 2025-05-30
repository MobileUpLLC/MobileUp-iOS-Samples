import UIKit

enum TypicalTabBarFactory {
    static func createTypicalTabBarController(networkService: NetworkService) -> TypicalCustomTabBarController {
        let typicalTabBarFirstExampleController = TypicalTabBarFirstExampleFactory
            .createTypicalTabBarFirstExampleController()
        let typicalTabBarSecondExampleController = TypicalTabBarSecondExampleFactory
            .createTypicalTabBarSecondExampleController()
        
        let coordinator = TabBarCoordinator(networkService: networkService)
        let viewModel = TypicalTabBarViewModel(coordinator: coordinator)
        let controller = TypicalCustomTabBarController(
            viewModel: viewModel,
            controllers: [typicalTabBarFirstExampleController, typicalTabBarSecondExampleController]
        )
        coordinator.router = controller

        return controller
    }
}
