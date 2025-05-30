import UIKit

enum BottomSheetExampleFactory {
    static func createBottomSheetExampleController(networkService: NetworkService) -> UINavigationController {
        let coordinator = BottomSheetExampleCoordinator(networkService: networkService)
        let authRepository = AuthRepository(networkService: networkService)
        let viewModel = BottomSheetExampleViewModel(coordinator: coordinator, authRepository: authRepository)
        let controller = BottomSheetExampleController(viewModel: viewModel)
        coordinator.router = controller

        return UINavigationController(rootViewController:controller)
    }
}
