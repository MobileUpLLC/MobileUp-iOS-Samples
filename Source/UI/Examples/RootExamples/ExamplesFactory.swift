import UIKit

enum ExamplesFactory {
    static func createExamplesController(networkService: NetworkService) -> UINavigationController {
        let coordinator = ExamplesCoordinator(networkService: networkService)
        let viewModel = ExamplesViewModel(coordinator: coordinator)
        let controller = ExamplesController(viewModel: viewModel)
        coordinator.router = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
