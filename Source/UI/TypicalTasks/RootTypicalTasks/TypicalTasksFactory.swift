import UIKit

enum TypicalTasksFactory {
    static func createTypicalTasksController(networkService: NetworkService) -> UINavigationController {
        let coordinator = TypicalTasksCoordinator(networkService: networkService)
        let authRepository = AuthRepository(networkService: networkService)
        let viewModel = TypicalTasksViewModel(coordinator: coordinator, authRepository: authRepository)
        let controller = TypicalTasksController(viewModel: viewModel)
        coordinator.router = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
