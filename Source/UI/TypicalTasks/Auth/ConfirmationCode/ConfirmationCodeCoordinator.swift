final class ConfirmationCodeCoordinator {
    weak var router: (RootRouter & PresentationRouter & ToastRouter & NavigationRouter)?
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func showErrorToast(with message: String = R.string.common.errorStateTitle()) {
        router?.showToast(with: .init(message: message, style: .failure))
    }
    
    func pop() {
        router?.pop(isAnimated: true)
    }
    
    @MainActor func showTabBarScreen() async {
        let controller = await TabBarFactory.createTabbarController(networkService: networkService)
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
    
    func dismiss() {
        router?.dismiss(isAnimated: true, completion: nil)
    }
}
