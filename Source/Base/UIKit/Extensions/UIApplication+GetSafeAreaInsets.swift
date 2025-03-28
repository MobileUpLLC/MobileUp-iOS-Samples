import UIKit

extension UIApplication {
    private static var safeAreaInsets: UIEdgeInsets?
    
    static func getSafeAreaInsets() -> UIEdgeInsets {
        if let safeAreaInsets {
            return safeAreaInsets
        }
        
        guard let safeAreaInsets = Self.shared.keyWindow?.rootViewController?.view.safeAreaInsets else {
            return .zero
        }
        
        self.safeAreaInsets = safeAreaInsets
        
        return safeAreaInsets
    }
}
