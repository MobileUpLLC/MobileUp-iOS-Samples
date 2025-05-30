final class RootCoordinator {
    weak var router: RootRouter?

    private var networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func showEntrance() {
        let controller = EntranceFactory.createEntranceController(networkService: networkService)
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
    
    @MainActor
    func showTabBar() async {
        let controller = await TabBarFactory.createTabbarController(networkService: networkService)
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
}
