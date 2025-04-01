import UIKit

enum TypicalTasksFactory {
    static func createTypicalTasksController() -> UINavigationController {
        let coordinator = TypicalTasksCoordinator()
        let viewModel = TypicalTasksViewModel(coordinator: coordinator)
        let controller = TypicalTasksController(viewModel: viewModel)
        coordinator.router = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
