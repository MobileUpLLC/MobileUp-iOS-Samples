import UIKit

final class TypicalTabBarSecondExampleController:
    HostingController<TypicalTabBarSecondExampleView>,
    TypicalCustomTabBarItemProvider
{
    var tabBarItemIcon: UIImage
    
    init() {
        tabBarItemIcon = UIImage(systemName: "paperplane.fill") ?? UIImage()
        super.init(rootView: TypicalTabBarSecondExampleView())
    }
}
