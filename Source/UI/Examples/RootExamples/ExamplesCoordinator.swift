import Foundation

final class ExamplesCoordinator {
    weak var router: (PresentationRouter & NavigationRouter)?

    private var networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func showWebPageModule(pageModel: WebPageModel) {
        let controller = WebPageFactory.createWebPageController(pageModel: pageModel)
        
        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
    
    func showSkeletonModule() {
        let controller = SkeletonFactory.createSkeletonController()
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showBottomSheetExample() {
        let controller = BottomSheetExampleFactory.createBottomSheetExampleController(networkService: networkService)

        router?.push(controller: controller, isAnimated: true)
    }
    
    func showMultipleBottomSheetExample() {
        let controller = MultipleBottomSheetExampleFactory.createMultipleBottomSheetExampleController()
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showErrorHandlingModule() {
        let controller = ErrorHandlingFactory.createErrorHandlingController()
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showToastExampleModule() {
        let controller = ToastExampleFactory.createToastExampleController()

        router?.push(controller: controller, isAnimated: true)
    }
    
    func showStorageModule() {
        let controller = StorageFactory.createStorageController()
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showNetworkExampleModule() {
        let controller = NetworkExampleFactory.createNetworkExampleController(networkService: networkService)
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showOnboardingExampleModule() {
        let controller = OnboardingExampleFactory.createOnboardingExampleController()
        
        router?.push(controller: controller, isAnimated: true)
    }
}
