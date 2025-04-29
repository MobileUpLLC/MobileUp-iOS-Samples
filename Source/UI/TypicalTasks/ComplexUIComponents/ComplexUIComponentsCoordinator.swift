final class ComplexUIComponentsCoordinator {
    weak var router: PresentationRouter?

    private var networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func showTypicalTabBar() {
        let controller = TypicalTabBarFactory.createTypicalTabBarController(networkService: networkService)

        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
}
