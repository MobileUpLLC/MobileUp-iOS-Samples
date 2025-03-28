import UIKit

enum ToastExampleFactory {
    static func createToastExampleController() -> ToastExampleController {
        let coordinator = ToastExampleCoordinator()
        let viewModel = ToastExampleViewModel(coordinator: coordinator)
        let controller = ToastExampleController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
