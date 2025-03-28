import UIKit

extension UIApplication {
    private static var safeAreaInsets: UIEdgeInsets?
    
    static func resignResponder() {
        Self.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
