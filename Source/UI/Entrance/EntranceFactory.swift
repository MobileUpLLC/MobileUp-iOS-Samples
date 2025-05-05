import UIKit

enum EntranceFactory {
    static func createEntranceController(networkService: NetworkService) -> EntranceController {
        let coordinator = EntranceCoordinator(networkService: networkService)
        let viewModel = EntranceViewModel(coordinator: coordinator)
        let controller = EntranceController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
