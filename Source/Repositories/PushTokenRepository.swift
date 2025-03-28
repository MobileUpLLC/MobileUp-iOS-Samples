import UIKit

class PushTokenRepository {
    static let shared = PushTokenRepository()
    
    private init() {}
    
    func didRegisterForRemoteNotificationsWithDeviceToken(_ deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        
        Log.pushTokenRepository.debug(logEntry:
                .text("Did register remote notifications with APNS device token: \(token)")
        )
        
        // NOTE: Если нужно, чтобы наш сервер отправлял пуши, то нужно добавить
        // здесь отправку токена на сервер.
    }
    
    func didFailToRegisterForRemoteNotificationsWithError(_ error: Error) {
        Log.pushTokenRepository.debug(logEntry: .text("Did fail register remote notifications with error: \(error)"))
    }
}
