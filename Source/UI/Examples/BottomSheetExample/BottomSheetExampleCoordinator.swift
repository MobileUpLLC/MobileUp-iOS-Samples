final class BottomSheetExampleCoordinator {
    weak var router: (PresentationRouter & RootRouter)?
    
    func showSkeletonModule() {
        let controller = SkeletonFactory.createSkeletonController()
        
        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
    
    func showExampleModule() {
        let controller = TabBarFactory.createTabbarController()
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
}
