import UIKit
import AppTrackingTransparency

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        AnalyticsService.shared.configure(providers: [FirebaseService.shared])
        Environments.setup()
        DeepLinkService.shared.configure(launchOptions: launchOptions, providers: [URLSchemeDeepLinkProvider.shared])
        
        onMainAfter(deadline: .now() + .one) {
            ATTrackingManager.requestTrackingAuthorization { _ in }
        }
        
        return true
    }
}

extension AppDelegate {
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        PushTokenRepository.shared.didRegisterForRemoteNotificationsWithDeviceToken(deviceToken)
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        PushTokenRepository.shared.didFailToRegisterForRemoteNotificationsWithError(error)
    }
}
