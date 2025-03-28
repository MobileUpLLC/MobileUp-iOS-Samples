import UIKit

enum NetworkExampleFactory {
    static func createNetworkExampleController() -> NetworkExampleController {
        let coordinator = NetworkExampleCoordinator()
        let viewModel = NetworkExampleViewModel(coordinator: coordinator, mobileService: .shared)
        let controller = NetworkExampleController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
