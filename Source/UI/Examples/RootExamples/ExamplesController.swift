import SwiftUI

final class ExamplesController: HostingController<ExamplesView>, CustomTabBarItemProvider {
    var tabBarItemIcon: UIImage
    
    init(viewModel: ExamplesViewModel) {
        tabBarItemIcon = UIImage(systemName: "rectangle.on.rectangle") ?? UIImage()
        super.init(rootView: ExamplesView(viewModel: viewModel))
    }
}
