final class AuthorizationCoordinator {
    weak var router: (ToastRouter & RootRouter & NavigationRouter)?
    
    func showErrorToast(with error: Error) {
        router?.showToast(with: .init(message: error.localizedDescription, style: .failure))
    }
    
    func showTabBarScreen() {
        let controller = TabBarFactory.createTabbarController()
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
    
    func showConfirmCodeScreen(with email: String) {
        let controller = ConfirmationCodeFactory.createConfirmationCodeController(
            email: email,
            resendCodeInterval: 60,
            displayType: .push
        )
        
        router?.push(controller: controller, isAnimated: true)
    }
}
