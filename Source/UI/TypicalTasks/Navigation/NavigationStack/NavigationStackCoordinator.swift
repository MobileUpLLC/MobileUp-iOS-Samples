final class NavigationStackCoordinator {
    weak var router: NavigationRouter?
    
    func showNavigationStackController() {
        let controller = NavigationStackFactory.createNavigationStackController()
        router?.push(controller: controller, isAnimated: true)
    }
    
    func pop() {
        router?.pop(isAnimated: true)
    }
    
    func popToRoot() {
        router?.popToRoot(isAnimated: true)
    }
    
    func popToNavigationController() {
        router?.pop(to: NavigationController.self, isAnimated: true)
    }
}
