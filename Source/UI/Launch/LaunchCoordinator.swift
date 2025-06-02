final class LaunchCoordinator {
    weak var router: RootRouter?
    
    @MainActor func showTabbarModule(networkService: NetworkService) async {
        let tabBarController = await TabBarFactory.createTabbarController(networkService: networkService)
        
        router?.showApplicationRoot(controller: tabBarController, animated: true)
    }
}
