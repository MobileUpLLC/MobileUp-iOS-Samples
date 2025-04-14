import UIKit

final class RegistrationCoordinator {
    weak var router: (NavigationRouter & ToastRouter & PresentationRouter & RootRouter)?
    
    func showConfirmationScreen(
        with email: String,
        resendCodeInterval: TimeInterval
    ) {
        let controller = ConfirmationCodeFactory.createConfirmationCodeController(
            credentials: email,
            resendCodeInterval: resendCodeInterval,
            displayType: .push
        )
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func openWebDocument(with pageModel: WebPageModel) {
        let controller = WebPageFactory.createWebPageController(pageModel: pageModel)
        controller.modalPresentationStyle = .fullScreen
        
        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
    
    func showErrorToast() {
        router?.showToast(with: .createWentWrongToastItem())
    }
    
    func showTabBarScreen() {
        let controller = TabBarFactory.createTabbarController()
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
}
