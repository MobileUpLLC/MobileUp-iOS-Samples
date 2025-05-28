final class TypicalTasksCoordinator {
    weak var router: (NavigationRouter & ToastRouter & RootRouter & PresentationRouter)?
    
    func showAuthorizationModule() {
        let controller = AuthorizationFactory.createAuthorizationController()
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showLists() {
        let controller = ListsFactory.createListsController()
        controller.modalPresentationStyle = .fullScreen
        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
    
    func showComplexUIComponents() {
        let controller = ComplexUIComponentsFactory.createComplexUIComponentsController()
        controller.modalPresentationStyle = .fullScreen
        router?.present(controller: controller, isAnimated: true, completion: nil)
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
