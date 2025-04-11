import UIKit

enum EntranceFactory {
    static func createEntranceController() -> NavigationController {
        let coordinator = EntranceCoordinator()
        let viewModel = EntranceViewModel(coordinator: coordinator)
        let controller = EntranceController(viewModel: viewModel)
        coordinator.router = controller
        
        return NavigationController(rootViewController: controller)
    }
}
