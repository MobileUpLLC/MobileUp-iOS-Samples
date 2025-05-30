final class EntranceCoordinator {
    weak var router: NavigationRouter?
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func showAuthorizationModule() {
        let controller = AuthorizationFactory.createAuthorizationController(networkService: networkService)
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showRegistrationModule() {
        let controller = RegistrationFactory.createRegistrationController(networkService: networkService)
        
        router?.push(controller: controller, isAnimated: true)
    }
}
