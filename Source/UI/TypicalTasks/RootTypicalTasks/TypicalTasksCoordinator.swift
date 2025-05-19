final class TypicalTasksCoordinator {
    weak var router: (NavigationRouter & PresentationRouter)?
    
    func showAuthorizationModule() {
        // TODO: UPUP-1022 Реализовать открытие модуля авторизации
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
    
    func showMultimedia() {
        let controller = MultimediaFactory.createMiltimediaController()
        controller.modalPresentationStyle = .fullScreen
        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
}
