import UIKit

enum WebPageFactory {
    static func createWebPageController(pageModel: WebPageModel) -> UINavigationController {
        let coordinator = WebPageCoordinator()
        let viewModel = WebPageViewModel(
            coordinator: coordinator,
            pageModel: pageModel
        )
        let controller = WebPageController(viewModel: viewModel)
        coordinator.router = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
