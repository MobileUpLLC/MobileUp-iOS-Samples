import UIKit

enum RootFactory {
    static func createRootController(with flow: InitialNavigationFlow) -> RootController {
        let coordinator = RootCoordinator()
        let viewModel = RootViewModel(coordinator: coordinator, flow: flow)
        let controller = RootController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
