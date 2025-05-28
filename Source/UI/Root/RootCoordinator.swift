final class RootCoordinator {
    weak var router: RootRouter?
    
    func showEntrance() {
        let controller = EntranceFactory.createEntranceController()
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
    
    func showTabBar() {
        let controller = TabBarFactory.createTabbarController()
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
}
