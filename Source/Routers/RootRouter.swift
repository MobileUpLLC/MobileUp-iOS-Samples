import UIKit

protocol RootRouter: AnyObject {
    func showApplicationRoot(controller: UIViewController, animated: Bool)
}

extension UIViewController: RootRouter {
    func showApplicationRoot(controller: UIViewController, animated: Bool) {
        let rootController = UIApplication.shared.rootController
        
        rootController?.presentedViewController?.dismiss()
        rootController?.addChild(controller: controller)
    }
}
