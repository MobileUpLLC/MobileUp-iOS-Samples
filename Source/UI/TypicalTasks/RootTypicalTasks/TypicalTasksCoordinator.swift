final class TypicalTasksCoordinator {
    weak var router: (NavigationRouter & PresentationRouter)?
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func showAuthorizationModule() {
        // TODO: UPUP-1022 Реализовать открытие модуля авторизации
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
    
    func showFavouritesModule() {
        let controller = FavouritesListFactory.createFavouritesListController(networkService: networkService)
        
        router?.push(controller: controller, isAnimated: true)
    }
}
