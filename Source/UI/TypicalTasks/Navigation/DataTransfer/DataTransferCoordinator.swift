final class DataTransferCoordinator {
    weak var router: NavigationRouter?
    
    func showDataTransferModule() {
        let controller = DataTransferFactory.createDataTransferController(onTextSubmit: nil)
        router?.push(controller: controller, isAnimated: true)
    }
    
    func popToNavigationController() {
        router?.pop(to: NavigationController.self, isAnimated: true)
    }
}
