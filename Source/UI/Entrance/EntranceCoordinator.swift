final class EntranceCoordinator {
    weak var router: (NavigationRouter & RootRouter)?
    
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
    
    @MainActor func showTabbarModule() async {
        let tabBarController = await TabBarFactory.createTabbarController(networkService: networkService)
        
        router?.showApplicationRoot(controller: tabBarController, animated: true)
    }
}
