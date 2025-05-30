final class AuthorizationCoordinator {
    weak var router: (ToastRouter & RootRouter & NavigationRouter)?
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func showErrorToast(with error: Error) {
        router?.showToast(with: .init(message: error.localizedDescription, style: .failure))
    }
    
    @MainActor func showTabBarScreen() async {
        let controller = await TabBarFactory.createTabbarController(networkService: networkService)
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
    
    func showConfirmCodeScreen(with email: String) {
        let controller = ConfirmationCodeFactory.createConfirmationCodeController(
            networkService: networkService,
            credentials: email,
            resendCodeInterval: 60,
            displayType: .push
        )
        
        router?.push(controller: controller, isAnimated: true)
    }
}
