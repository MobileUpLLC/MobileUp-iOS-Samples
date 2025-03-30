import UIKit

enum SplashFactory {
    static func createSplashController(completion: @escaping Closure.Generic<InitialNavigationFlow>) -> SplashController {
        let coordinator = SplashCoordinator()
        let authRepository = AuthRepository()
        let viewModel = SplashViewModel(
            coordinator: coordinator,
            mobileService: .shared,
            authRepository: authRepository,
            completion: completion
        )
        let controller = SplashController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
