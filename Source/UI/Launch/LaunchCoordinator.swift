final class LaunchCoordinator {
    weak var router: RootRouter?

    func showTabbarModule(networkService: NetworkService) {
        let tabBarController = TabBarFactory.createTabbarController(networkService: networkService)

        router?.showApplicationRoot(controller: tabBarController, animated: true)
    }
}
