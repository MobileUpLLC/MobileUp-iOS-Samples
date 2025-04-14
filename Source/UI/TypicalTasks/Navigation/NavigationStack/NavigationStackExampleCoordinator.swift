final class NavigationStackExampleCoordinator {
    weak var router: NavigationRouter?
    
    func showNavigationStackExampleController() {
        let controller = NavigationStackExampleFactory.createNavigationStackExampleController()
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func pop() {
        router?.pop(isAnimated: true)
    }
    
    func popToRoot() {
        router?.popToRoot(isAnimated: true)
    }
    
    func popToNavigationExampleController() {
        router?.pop(to: NavigationExampleController.self, isAnimated: true)
    }
}
