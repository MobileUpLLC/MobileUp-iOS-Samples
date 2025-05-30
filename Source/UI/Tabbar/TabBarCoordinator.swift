final class TabBarCoordinator {
    weak var router: (TabBarRouter & RootRouter)?

    private var networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func openBottomSheet() {
        router?.selectTab(index: .one)
    }
    
    @MainActor func openLaunch() async {
        let controller = await LaunchFactory.createLaunchController(networkService: networkService)
        router?.showApplicationRoot(controller: controller, animated: true)
    }
}
