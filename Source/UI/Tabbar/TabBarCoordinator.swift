final class TabBarCoordinator {
    weak var router: (TabBarRouter & RootRouter)?
    
    func openBottomSheet() {
        router?.selectTab(index: .one)
    }
    
    func openLaunch() {
        let controller = LaunchFactory.createLaunchController()
        router?.showApplicationRoot(controller: controller, animated: true)
    }
}
