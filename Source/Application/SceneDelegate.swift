import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let rootViewController = LaunchFactory.createLaunchController()
        
        window?.rootViewController = rootViewController
        
        if let userActivity = connectionOptions.userActivities.first {
            DeepLinkService.shared.handleDeepLink(scene: scene, userActivity: userActivity)
        } else if connectionOptions.urlContexts.isEmpty == false {
            DeepLinkService.shared.handleDeepLink(scene: scene, urlContexts: connectionOptions.urlContexts)
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        DeepLinkService.shared.handleDeepLink(scene: scene, urlContexts: URLContexts)
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        DeepLinkService.shared.handleDeepLink(scene: scene, userActivity: userActivity)
    }
}
