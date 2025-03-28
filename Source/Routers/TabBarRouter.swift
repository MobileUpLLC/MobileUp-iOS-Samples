import UIKit

protocol TabBarRouter: AnyObject {
    func selectTab(index: Int)
}

extension UIViewController: TabBarRouter {
    func selectTab(index: Int) {
        customTabBarController?.selectedIndex = index
    }
}
