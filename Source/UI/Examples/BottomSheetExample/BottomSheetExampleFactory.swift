import UIKit

enum BottomSheetExampleFactory {
    static func createBottomSheetExampleController(networkService: NetworkService) -> UIViewController {
        let coordinator = BottomSheetExampleCoordinator(networkService: networkService)
        let authRepository = AuthRepository(networkService: networkService)
        let viewModel = BottomSheetExampleViewModel(coordinator: coordinator, authRepository: authRepository)
        let controller = BottomSheetExampleController(viewModel: viewModel)
        coordinator.router = controller

        return controller
    }
    
    static func createBottomSheetNavigationContriller(networkService: NetworkService) -> NavigationController {
        let coordinator = BottomSheetExampleCoordinator(networkService: networkService)
        let authRepository = AuthRepository(networkService: networkService)
        let viewModel = BottomSheetExampleViewModel(coordinator: coordinator, authRepository: authRepository)
        let controller = BottomSheetExampleController(viewModel: viewModel)
        coordinator.router = controller

        return NavigationController(rootViewController: controller)
    }
}
