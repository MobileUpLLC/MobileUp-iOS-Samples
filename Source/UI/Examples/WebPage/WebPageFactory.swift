enum WebPageFactory {
    static func createWebPageController(pageModel: WebPageModel) -> NavigationController {
        let coordinator = WebPageCoordinator()
        let viewModel = WebPageViewModel(
            coordinator: coordinator,
            pageModel: pageModel
        )
        let controller = WebPageController(viewModel: viewModel)
        coordinator.router = controller
        
        return NavigationController(rootViewController: controller)
    }
}
