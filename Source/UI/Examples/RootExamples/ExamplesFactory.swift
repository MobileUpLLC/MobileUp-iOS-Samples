import UIKit

enum ExamplesFactory {
    static func createExamplesController() -> UINavigationController {
        let coordinator = ExamplesCoordinator()
        let viewModel = ExamplesViewModel(coordinator: coordinator)
        let controller = ExamplesController(viewModel: viewModel)
        coordinator.router = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
