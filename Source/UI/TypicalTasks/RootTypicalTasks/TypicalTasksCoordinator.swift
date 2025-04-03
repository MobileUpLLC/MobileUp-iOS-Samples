final class TypicalTasksCoordinator {
    weak var router: NavigationRouter?
    
    func showAuthorizationModule() {
        let controller = AuthorizationFactory.createAuthorizationController()
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showNavigationModule() {
        let controller = NavigationFactory.createNavigationController()
        router?.push(controller: controller, isAnimated: true)
    }
}
