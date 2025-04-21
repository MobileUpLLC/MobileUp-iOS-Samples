import UIKit

final class TypicalTabBarFirstExampleController:
    HostingController<TypicalTabBarFirstExampleView>,
    TypicalCustomTabBarItemProvider {
    var tabBarItemIcon: UIImage
    
    init() {
        tabBarItemIcon = UIImage(systemName: "car.fill") ?? UIImage()
        super.init(rootView: TypicalTabBarFirstExampleView())
    }
}
