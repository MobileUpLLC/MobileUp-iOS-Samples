final class BottomSheetExampleCoordinator {
    weak var router: (PresentationRouter & RootRouter & ToastRouter)?
    
    func showSkeletonModule() {
        let controller = SkeletonFactory.createSkeletonController()
        
        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
    
    func showExampleModule() {
        let controller = TabBarFactory.createTabbarController()
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
    
    func showErrorToast(with error: Error) {
        router?.showToast(with: .init(message: error.localizedDescription, style: .failure))
    }
}
