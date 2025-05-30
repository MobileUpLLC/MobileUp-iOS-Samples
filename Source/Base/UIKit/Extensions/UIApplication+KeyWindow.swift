import UIKit

extension UIApplication {
    var keyWindow: UIWindow? { getKeyWindow() }
    var rootController: RootController? { getRootController() }
    
    private func getKeyWindow() -> UIWindow? {
        let windowScene = connectedScenes.first as? UIWindowScene
        
        if let keyWindow = windowScene?.windows.first(where: { $0.isKeyWindow }) {
            return keyWindow
        } else {
            Log.uiApplication.debug(logEntry: .text("Key window not found"))
            return nil
        }
    }
    
    private func getRootController() -> RootController? {
        if let rootController = keyWindow?.rootViewController as? RootController {
            return rootController
        } else {
            assertionFailure("rootController is nil")
            
            return nil
        }
    }
}
