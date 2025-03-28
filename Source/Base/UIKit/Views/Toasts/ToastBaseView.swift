import UIKit
import SnapKit

protocol Toast: UIView {
    var swipeDirection: UISwipeGestureRecognizer.Direction { get }
    var onTap: Closure.Void? { get }
    var onSwipe: Closure.Void? { get }
    
    func setup(
        swipeDirection: UISwipeGestureRecognizer.Direction,
        onTap: Closure.Void?,
        onSwipe: Closure.Void?
    )
}

class ToastBaseView: BaseView, Toast {
    var swipeDirection: UISwipeGestureRecognizer.Direction = .down
    var onTap: Utils.Closure.Void?
    var onSwipe: Utils.Closure.Void?
    
    func setup(
        swipeDirection: UISwipeGestureRecognizer.Direction,
        onTap: Closure.Void?,
        onSwipe: Closure.Void?
    ) {
        self.swipeDirection = swipeDirection
        self.onTap = onTap
        self.onSwipe = onSwipe
        
        setupGestureRecognizers()
    }
    
    private func setupGestureRecognizers() {
        let toastTapGesture = UITapGestureRecognizer(target: self, action: #selector(toastDidTap))
        toastTapGesture.delegate = self
        let toastSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(toastDidSwipe))
        toastSwipeGesture.direction = swipeDirection
        
        addGestureRecognizer(toastTapGesture)
        addGestureRecognizer(toastSwipeGesture)
    }

    @objc private func toastDidTap() {
        onTap?()
    }
    
    @objc private func toastDidSwipe() {
        onSwipe?()
    }
}

extension ToastBaseView: UIGestureRecognizerDelegate {
   func gestureRecognizer(
       _ gestureRecognizer: UIGestureRecognizer,
       shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
   ) -> Bool {
       return true
   }
}
