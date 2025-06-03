import UIKit

final class OnboardingExampleCoordinator {
    weak var router: (PresentationRouter & NavigationRouter)?
    
    func showCommonOnboardingScreen(onboardingType: CommonOnboardingType) {
        let controller = CommonOnboardingFactory.createCommonOnboardingController(with: onboardingType)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .fullScreen
        
        router?.present(controller: navigationController, isAnimated: true, completion: nil)
    }
    
    func showOnboardingWithElementFocus() {
        if #available(iOS 17.0, *) {
            let controller = OnboardingWithElementFocusFactory.createOnboardingWithElementFocusController()
            router?.push(controller: controller, isAnimated: true)
        } else {
            print("Fallback on earlier versions")
        }
    }
}
