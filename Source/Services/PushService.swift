import UserNotifications
import UIKit

class PushService: NSObject {
    static let shared = PushService()
    
    var onPushReceive: Closure.Generic<PushPayloadModel>? {
        didSet {
            guard let buffer else {
                return
            }
            
            self.buffer = nil
            
            onMain { [weak self] in
                self?.onPushReceive?(buffer)
            }
        }
    }
    
    private var buffer: PushPayloadModel?
    
    override private init() {
        super.init()
    
        UNUserNotificationCenter.current().delegate = self
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func requestAuthorization(options: UNAuthorizationOptions = [.alert, .sound, .badge]) async throws -> Bool {
        try await UNUserNotificationCenter.current().requestAuthorization(options: options)
    }

    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        let center = UNUserNotificationCenter.current()

        center.getNotificationSettings { settings in
            completion(settings.authorizationStatus)
        }
    }
    
    private func handleRemoteNotification(with userInfo: [AnyHashable: Any]) {
        Log.pushService.info(logEntry: .detailed(text: "Remote notification recieved", parameters: userInfo))
        
        guard let model = decode(userInfo: userInfo) else {
            return
        }
        
        if let onPushReceive {
            onPushReceive(model)
        } else {
            buffer = model
        }
    }
    
    private func decode(userInfo: [AnyHashable: Any]) -> PushPayloadModel? {
        guard let infoDict = userInfo as? [String: Any] else {
            return nil
        }
        
        do {
            return try JSONConverter.decode(PushPayloadModel.self, dictionary: infoDict)
        } catch let error {
            Log.pushService.error(logEntry: .text("Failed to decode payload. Error: \(error)"))
        }
        
        return nil
    }
}

extension PushService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .badge, .list, .sound])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        handleRemoteNotification(with: response.notification.request.content.userInfo)
        
        completionHandler()
    }
}
