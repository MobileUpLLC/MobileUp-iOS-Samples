import UIKit

enum LogsFactory {
    static func createLogsController() -> UINavigationController {
        let controller = LogsController()
        
        return UINavigationController(rootViewController: controller)
    }
}
