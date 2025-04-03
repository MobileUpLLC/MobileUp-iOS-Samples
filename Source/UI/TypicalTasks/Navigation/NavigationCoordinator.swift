final class NavigationCoordinator {
    weak var router: NavigationRouter?
    
    func showNavigationStackModule() {
        let controller = NavigationStackFactory.createNavigationStackController()
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showPresentationModule() {
        let controller = PresentationFactory.createPresentationController()
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showDataTransferModule(onTextSubmit: @escaping (String) -> Void) {
        let controller = DataTransferFactory.createDataTransferController(onTextSubmit: onTextSubmit)
        router?.push(controller: controller, isAnimated: true)
    }
}
