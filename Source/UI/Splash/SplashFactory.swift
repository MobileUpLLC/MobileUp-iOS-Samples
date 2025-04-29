import UIKit
import munkit

enum SplashFactory {
    static func createSplashController(
        networkService: NetworkService,
        completion: @escaping Closure.Generic<InitialNavigationFlow>
    ) async -> SplashController {
        let authRepository = AuthRepository(networkService: networkService)

        await networkService.setAuthorizationObjects(
            provider: authRepository,
            refresher: authRepository,
            tokenRefreshFailureHandler: { completion(.entrance) }
        )

        let coordinator = SplashCoordinator()
        let viewModel = SplashViewModel(
            coordinator: coordinator,
            networkService: networkService,
            authRepository: authRepository,
            completion: completion
        )
        let controller = await SplashController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
