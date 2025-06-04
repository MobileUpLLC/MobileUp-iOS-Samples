final class BottomSheetExampleCoordinator {
    weak var router: (PresentationRouter & RootRouter & ToastRouter)?

    private var networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func showSkeletonModule() {
        let controller = SkeletonFactory.createSkeletonController()

        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
    
    @MainActor func showExampleModule() async {
        let controller = await TabBarFactory.createTabbarController(networkService: networkService)
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
    
    func showEntrance() {
        let controller = EntranceFactory.createEntranceController(networkService: networkService)
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
    
    func showErrorToast(with error: Error) {
        router?.showToast(with: .init(message: error.localizedDescription, style: .failure))
    }
}
