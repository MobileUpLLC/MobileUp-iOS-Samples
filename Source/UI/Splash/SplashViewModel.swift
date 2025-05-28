import Foundation

enum InitialNavigationFlow {
    case entrance
    case tabBar
}

final class SplashViewModel: ViewModel {
    private let coordinator: SplashCoordinator
    private let mobileService: MobileService
    private let authRepository: AuthRepository
    private let completion: Closure.Generic<InitialNavigationFlow>
    
    init(
        coordinator: SplashCoordinator,
        mobileService: MobileService,
        authRepository: AuthRepository,
        completion: @escaping Closure.Generic<InitialNavigationFlow>
    ) {
        self.coordinator = coordinator
        self.authRepository = authRepository
        self.mobileService = mobileService
        self.completion = completion
        
        super.init()
        
        self.mobileService.onTokenRefreshFailed = { [weak self] in
            Perform { [weak self] in
                // TODO: UPUP-1022 Добавить чистку кейчейна
                
                onMain { [weak self] in
                    self?.completion(.entrance)
                }
            }
        }
    }
    
    func handleViewAppear() {
        if authRepository.refreshToken == nil {
            completion(.entrance)
        } else {
            completion(.tabBar)
        }
    }
}
