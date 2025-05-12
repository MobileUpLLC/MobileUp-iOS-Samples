final class ComplexUIComponentsCoordinator {
    weak var router: PresentationRouter?
    
    func showTypicalTabBar() {
        let controller = TypicalTabBarFactory.createTypicalTabBarController()
        
        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
}
