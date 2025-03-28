import UIKit

final class BottomSheetExampleController: HostingController<BottomSheetExampleView>, CustomTabBarItemProvider {
    var tabBarItemIcon: UIImage
    
    init(viewModel: BottomSheetExampleViewModel) {
        tabBarItemIcon = UIImage(systemName: "rectangle.stack") ?? UIImage()
        super.init(rootView: BottomSheetExampleView(viewModel: viewModel))
    }
}
