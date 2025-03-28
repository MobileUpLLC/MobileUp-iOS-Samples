import Foundation

enum VPNDetectionUtil {
    static func isVPNConnected() -> Bool {
        let internetProxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as NSDictionary?
        let internetProxySettingsScoped = internetProxySettings?["__SCOPED__"] as? NSDictionary
        
        guard let keys = internetProxySettingsScoped?.allKeys as? [String] else {
            return false
        }
        
        for key in keys {
            if
                key.contains("tap")
                || key.contains("tun")
                || key.contains("ppp")
                || key.contains("ipsec")
                || key.contains("utun")
            {
                return true
            }
        }
        
        return false
    }
}
