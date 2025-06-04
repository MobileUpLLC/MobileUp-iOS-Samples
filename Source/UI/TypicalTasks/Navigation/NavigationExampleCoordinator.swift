final class NavigationExampleCoordinator {
    weak var router: (NavigationRouter & PresentationRouter)?
    
    func showNavigationStackExampleModule() {
        let controller = NavigationStackExampleFactory.createNavigationStackExampleController()
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showPresentationExampleModule() {
        let controller = PresentationExampleFactory.createPresentationExampleController()
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showDataTransferExampleModule(onTextSubmit: Closure.String?) {
        let controller = DataTransferExampleFactory.createDataTransferExampleController(onTextSubmit: onTextSubmit)
        
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
