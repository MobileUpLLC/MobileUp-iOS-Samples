final class LaunchCoordinator {
    weak var router: RootRouter?
    
    func showTabbarModule() {
        let tabBarController = TabBarFactory.createTabbarController()
        
        router?.showApplicationRoot(controller: tabBarController, animated: true)
    }
}
