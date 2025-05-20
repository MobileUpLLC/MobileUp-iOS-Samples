final class RootCoordinator {
    weak var router: RootRouter?

    private var networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func showEntrance() {
        let controller = EntranceFactory.createEntranceController()
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
    
    func showTabBar() {
        let controller = TabBarFactory.createTabbarController(networkService: networkService)
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
}
