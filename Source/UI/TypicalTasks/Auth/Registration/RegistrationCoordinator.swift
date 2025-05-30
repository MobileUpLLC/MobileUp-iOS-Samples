import UIKit

final class RegistrationCoordinator {
    weak var router: (NavigationRouter & ToastRouter & PresentationRouter & RootRouter)?
    
    private var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func showConfirmationScreen(
        with email: String,
        resendCodeInterval: TimeInterval
    ) {
        let controller = ConfirmationCodeFactory.createConfirmationCodeController(
            networkService: networkService,
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
    
    func showTabBarScreen() async {
        let controller = await TabBarFactory.createTabbarController(networkService: networkService)
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
}
