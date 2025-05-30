import UIKit

enum DeviceUtil {
    static let udid: String? = UIDevice.current.identifierForVendor?.uuidString
    static let currentAppVersion = Bundle.appVersion
    static let currentBuildNumber = Bundle.buildNumber
    static let device = UIDevice.current.model
    static let vendor = UIDevice.current.identifierForVendor?.uuidString
    static let systemVersion = UIDevice.current.systemVersion
    static let os = UIDevice.current.systemName
}
