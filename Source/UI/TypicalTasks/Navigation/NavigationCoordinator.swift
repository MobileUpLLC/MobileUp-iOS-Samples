final class NavigationCoordinator {
    weak var router: (NavigationRouter & PresentationRouter)?
    
    func showNavigationStackModule() {
        let controller = NavigationStackFactory.createNavigationStackController()
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showPresentationModule() {
        let controller = PresentationFactory.createPresentationController()
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showDataTransferModule(onTextSubmit: Closure.String?) {
        let controller = DataTransferFactory.createDataTransferController(onTextSubmit: onTextSubmit)
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showSkeletonModule() {
        let controller = SkeletonFactory.createSkeletonController()
        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
    
    func showMultipleBottomSheetModule() {
        let controller = MultipleBottomSheetExampleFactory.createMultipleBottomSheetExampleController()
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showToastExampleModule() {
        let controller = ToastExampleFactory.createToastExampleController()
        router?.push(controller: controller, isAnimated: true)
    }
}
