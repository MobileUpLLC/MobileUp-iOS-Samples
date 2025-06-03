final class TypicalTasksCoordinator {
    weak var router: (NavigationRouter & ToastRouter & RootRouter & PresentationRouter)?
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func showAuthorizationModule() {
        let controller = AuthorizationFactory.createAuthorizationController(networkService: networkService)
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showLists() {
        let controller = ListsFactory.createListsController()
        controller.modalPresentationStyle = .fullScreen
        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
    
    func showComplexUIComponents() {
        let controller = ComplexUIComponentsFactory.createComplexUIComponentsController(networkService: networkService)
        controller.modalPresentationStyle = .fullScreen
        router?.present(controller: controller, isAnimated: true, completion: nil)
	}
	
    func showSignInPhone() {
        let controller = SignInPhoneFactory.createSignInPhoneController(networkService: networkService)
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showEntrance() {
        let controller = EntranceFactory.createEntranceController(networkService: networkService)
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
    
    func showErrorToast(with error: Error) {
        router?.showToast(with: .init(message: error.localizedDescription, style: .failure))
    }
    
    func showRegistrationModule() {
        let controller = RegistrationFactory.createRegistrationController(networkService: networkService)
        
        router?.push(controller: controller, isAnimated: true)
    }
        
    func showNavigationExampleModule() {
        let controller = NavigationExampleFactory.createNavigationExampleController()

		router?.push(controller: controller, isAnimated: true)
	}
    
    func showOnboardingExampleModule() {
        let controller = OnboardingExampleFactory.createOnboardingExampleController()
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showInputFormsModule() {
        let controller = InputFormsFactory.createInputFormsController()    
    
        router?.push(controller: controller, isAnimated: true)
    }

    func showFavouritesModule() {
        let controller = FavouritesListFactory.createFavouritesListController()
        
        router?.push(controller: controller, isAnimated: true)
    }
}
