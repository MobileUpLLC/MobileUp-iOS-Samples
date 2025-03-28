import Foundation
import UIKit

final class JailbreakDetectionUtil {
    private enum JailbreakPath: String, CaseIterable {
        case cydia = "/Applications/Cydia.app"
        case mobileSubstrate = "/Library/MobileSubstrate/MobileSubstrate.dylib"
        case bash = "/bin/bash"
        case sshd = "/usr/sbin/sshd"
        case ssh = "/usr/bin/ssh"
        case apt = "/etc/apt"
        case privateApt = "/private/var/lib/apt"
    }
    
    private enum Constants {
        static let cydiaURLScheme = "cydia://package/com.example.package"
        static let privateFolderPrefix = "/private/"
        static let privateFolderCheckText = "Check text"
    }
    
    static var isSecureDevice: Bool { isJailbreakDetected() == false }
    
    private static var fileManager: FileManager { .default }
    
    private init() { }
    
    private static func isJailbreakDetected() -> Bool {
        #if DEBUG
        return false
        #else
        if isCanOpenCydiaURLScheme() {
            return true
        }
        #if RELEASE && (arch(i386) || arch(x86_64))
        return true
        #endif
        return isJailbreakFileExist() || isCanOpenJailbreakFile() || isCanWriteToPrivateFolder()
        #endif
    }
    
    private static func isCanOpenCydiaURLScheme() -> Bool {
        guard let cydiaUrlScheme = URL(string: Constants.cydiaURLScheme) else {
            return false
        }
        
        return UIApplication.shared.canOpenURL(cydiaUrlScheme)
    }
    
    private static func isJailbreakFileExist() -> Bool {
        return JailbreakPath.allCases
            .map { fileManager.fileExists(atPath: $0.rawValue) }
            .contains(true)
    }
    
    private static func isCanOpenJailbreakFile() -> Bool {
        let canOpen: ((String) -> Bool) = { path in
            let file = fopen(path, "r")
            
            guard file != nil else {
                return false
            }
            
            fclose(file)
          
            return true
        }
        
        return JailbreakPath.allCases
            .map { canOpen($0.rawValue) }
            .contains(true)
    }
    
    private static func isCanWriteToPrivateFolder() -> Bool {
        let path = Constants.privateFolderPrefix + NSUUID().uuidString
        
        do {
            try Constants.privateFolderCheckText.write(toFile: path, atomically: true, encoding: .utf8)
            try fileManager.removeItem(atPath: path)
            
            return true
        } catch {
            return false
        }
    }
}
