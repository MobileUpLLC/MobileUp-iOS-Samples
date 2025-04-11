final class TypicalTasksCoordinator {
    weak var router: (NavigationRouter & ToastRouter & RootRouter)?
    
    func showAuthorizationModule() {
        let controller = AuthorizationFactory.createAuthorizationController()
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showSignInPhone() {
        let controller = SignInPhoneFactory.createSignInPhoneController()
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showEntrance() {
        let controller = EntranceFactory.createEntranceController()
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
    
    func showErrorToast(with error: Error) {
        router?.showToast(with: .init(message: error.localizedDescription, style: .failure))
    }
    
    func showRegistrationModule() {
        let controller = RegistrationFactory.createRegistrationController()
        
        router?.push(controller: controller, isAnimated: true)
    }
}
