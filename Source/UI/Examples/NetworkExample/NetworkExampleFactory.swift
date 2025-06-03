import UIKit

enum NetworkExampleFactory {
    static func createNetworkExampleController(networkService: NetworkService) -> NetworkExampleController {
        let coordinator = NetworkExampleCoordinator()
        let viewModel = NetworkExampleViewModel(coordinator: coordinator, networkService: networkService)
        let controller = NetworkExampleController(viewModel: viewModel)
        coordinator.router = controller

        return controller
    }
}
