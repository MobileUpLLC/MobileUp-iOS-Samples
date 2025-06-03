import UIKit

enum RootFactory {
    static func createRootController(
        networkService: NetworkService,
        with flow: InitialNavigationFlow
    ) -> RootController {
        let coordinator = RootCoordinator(networkService: networkService)
        let viewModel = RootViewModel(coordinator: coordinator, flow: flow)
        let controller = RootController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
