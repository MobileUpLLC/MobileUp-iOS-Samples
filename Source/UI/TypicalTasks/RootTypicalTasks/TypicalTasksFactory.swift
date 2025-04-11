import UIKit

enum TypicalTasksFactory {
    static func createTypicalTasksController() -> UINavigationController {
        let coordinator = TypicalTasksCoordinator()
        let authRepository = AuthRepository()
        let viewModel = TypicalTasksViewModel(coordinator: coordinator, authRepository: authRepository)
        let controller = TypicalTasksController(viewModel: viewModel)
        coordinator.router = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
