import UIKit

final class SignInPhoneCoordinator {
    weak var router: (RootRouter & NavigationRouter)?
    
    func goBack() {
        router?.pop(isAnimated: true)
    }
	
    func popToRoot() {
        router?.popToRoot(isAnimated: true)
    }
    
    func showTabBarScreen() {
        let controller = TabBarFactory.createTabbarController()
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
    
    func showConfirmationScreen(
        with phoneNumber: String,
        resendCodeInterval: TimeInterval
    ) {
        let controller = ConfirmationCodeFactory.createConfirmationCodeController(
            credentials: phoneNumber,
            resendCodeInterval: resendCodeInterval,
            displayType: .push
        )
        
        router?.push(controller: controller, isAnimated: true)
    }
    
//    func goToMain() {
//        let controller = BaseTabBarFactory.createTabBarController(selectedIndex: .one)
//        
//        router?.showApplicationRoot(controller: controller)
//    }
//    
//    func goToSignInCode(viewModelItem: SignInViewModelItem) {
//        let controller = SignInCodeFactory.createSignInCodeController(viewModelItem: viewModelItem)
//        
//        router?.push(controller: controller, isAnimated: true)
//    }
}
