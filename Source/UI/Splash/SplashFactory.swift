import UIKit
import munkit

enum SplashFactory {
    @MainActor static func createSplashController(
        networkService: NetworkService,
        completion: @escaping Closure.Generic<InitialNavigationFlow>
    ) async -> SplashController {
        let authRepository = AuthRepository(networkService: networkService)

        await networkService.setAuthorizationObjects(
            provider: authRepository,
            refresher: authRepository,
            tokenRefreshFailureHandler: {
                // TODO: вместе с di подумать куда можно убрать логику очистки хранилища
                try? authRepository.clearKeychainDataInStorage()
                completion(.entrance)
            }
        )

        let coordinator = SplashCoordinator()
        let viewModel = SplashViewModel(
            coordinator: coordinator,
            networkService: networkService,
            authRepository: authRepository,
            completion: completion
        )
        let controller = SplashController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
