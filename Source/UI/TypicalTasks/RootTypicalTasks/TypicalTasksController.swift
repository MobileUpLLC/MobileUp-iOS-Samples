import UIKit

final class TypicalTasksController: HostingController<TypicalTasksView>, CustomTabBarItemProvider {
    var tabBarItemIcon: UIImage
    
    init(viewModel: TypicalTasksViewModel) {
        tabBarItemIcon = UIImage(systemName: "book") ?? UIImage()
        super.init(rootView: TypicalTasksView(viewModel: viewModel))
    }
}
