final class TypicalTasksCoordinator {
    weak var router: NavigationRouter?
    
    func showAuthorizationModule() {
        let controller = AuthorizationFactory.createAuthorizationController()
        
        router?.push(controller: controller, isAnimated: true)
    }
}
