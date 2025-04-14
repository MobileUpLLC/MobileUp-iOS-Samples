final class ConfirmationCodeCoordinator {
    weak var router: (RootRouter & PresentationRouter & ToastRouter & NavigationRouter)?
    
    func showErrorToast(with message: String = R.string.common.errorStateTitle()) {
        router?.showToast(with: .init(message: message, style: .failure))
    }
    
    func pop() {
        router?.pop(isAnimated: true)
    }
    
    func showTabBarScreen() {
        let controller = TabBarFactory.createTabbarController()
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
    
    func dismiss() {
        router?.dismiss(isAnimated: true, completion: nil)
    }
}
