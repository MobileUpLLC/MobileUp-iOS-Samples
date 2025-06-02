final class DataTransferExampleCoordinator {
    weak var router: NavigationRouter?
    
    func showDataTransferExampleModule() {
        let controller = DataTransferExampleFactory.createDataTransferExampleController(onTextSubmit: nil)
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func popToNavigationExampleController() {
        router?.pop(to: NavigationExampleController.self, isAnimated: true)
    }
}
