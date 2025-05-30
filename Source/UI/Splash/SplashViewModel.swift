import Foundation

enum InitialNavigationFlow {
    case entrance
    case tabBar
}

final class SplashViewModel: ViewModel {
    private let coordinator: SplashCoordinator
    private let networkService: NetworkService
    private let authRepository: AuthRepository
    private let completion: Closure.Generic<InitialNavigationFlow>
    
    init(
        coordinator: SplashCoordinator,
        networkService: NetworkService,
        authRepository: AuthRepository,
        completion: @escaping Closure.Generic<InitialNavigationFlow>
    ) {
        self.coordinator = coordinator
        self.authRepository = authRepository
        self.networkService = networkService
        self.completion = completion
        
        super.init()
    }
    
    func handleViewAppear() {
        if authRepository.refreshToken == nil {
            completion(.entrance)
        } else {
            completion(.tabBar)
        }
    }
}
