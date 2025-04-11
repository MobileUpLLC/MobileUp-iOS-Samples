final class EntranceCoordinator {
    weak var router: NavigationRouter?
    
    func showAuthorizationModule() {
        let controller = AuthorizationFactory.createAuthorizationController()
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showRegistrationModule() {
        let controller = RegistrationFactory.createRegistrationController()
        
        router?.push(controller: controller, isAnimated: true)
    }
}
