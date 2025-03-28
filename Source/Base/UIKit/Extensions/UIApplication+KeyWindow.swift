import UIKit

extension UIApplication {
    var keyWindow: UIWindow? { getKeyWindow() }
    
    private func getKeyWindow() -> UIWindow? {
        let windowScene = connectedScenes.first as? UIWindowScene
        
        if let keyWindow = windowScene?.windows.first(where: { $0.isKeyWindow }) {
            return keyWindow
        } else {
            Log.uiApplication.debug(logEntry: .text("Key window not found"))
            return nil
        }
    }
}
