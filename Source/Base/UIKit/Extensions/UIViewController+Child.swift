import UIKit

extension UIViewController {
    private enum Constants {
        static let fadeAnimationDuration = 0.25
    }
    
    func addChild(controller: UIViewController, isAnimated: Bool = true) {
        view.layoutSubview(controller.view, safe: false)
        addChild(controller)
        
        if isAnimated {
            controller.view.alpha = .zero
            UIView.animate(withDuration: Constants.fadeAnimationDuration) {
                controller.view.alpha = .one
                if self.children.count > .one {
                    self.removeChild(controller: self.children.first)
                }
            }
        } else {
            if self.children.count > .one {
                self.removeChild(controller: self.children.first)
            }
        }
    }
    
    private func removeChild(controller: UIViewController?) {
        guard controller?.parent != nil else {
            return
        }

        controller?.willMove(toParent: nil)
        controller?.removeFromParent()
        controller?.view.removeFromSuperview()
    }
}
