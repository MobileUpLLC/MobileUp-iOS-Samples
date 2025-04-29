import UIKit
import AppTrackingTransparency
import TipKit

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
        
        if #available(iOS 17.0, *) {
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
            ])
        } else {
            // Fallback on earlier versions
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
