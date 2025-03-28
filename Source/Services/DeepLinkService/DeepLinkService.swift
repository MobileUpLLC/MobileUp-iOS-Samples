import UIKit

enum DeepLink {
    case test
}

protocol DeepLinkProvider: AnyObject {
    var onDeeplinkReceived: Closure.Generic<DeepLink>? { get set }
    
    func configure(launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    
    func handleDeepLink(scene: UIScene, urlContexts: Set<UIOpenURLContext>)
    func handleDeepLink(scene: UIScene, userActivity: NSUserActivity)
}

final class DeepLinkService {
    static let shared = DeepLinkService()
    
    var onDeeplinkReceived: Closure.Generic<DeepLink>? {
        didSet {
            guard let buffer else {
                return
            }
            
            self.buffer = nil
            
            onMain { [weak self] in
                self?.onDeeplinkReceived?(buffer)
            }
        }
    }
    
    private var buffer: DeepLink?
    private var providers: [DeepLinkProvider] = []

    func configure(launchOptions: [UIApplication.LaunchOptionsKey: Any]?, providers: [DeepLinkProvider]) {
        self.providers = providers

        providers.forEach { $0.configure(launchOptions: launchOptions) }
        
        providers.forEach { provider in
            provider.onDeeplinkReceived = { [weak self] deepLink in
                self?.handleDeepLinkReceived(deepLink: deepLink)
            }
        }
    }

    func handleDeepLink(scene: UIScene, urlContexts: Set<UIOpenURLContext>) {
        providers.forEach { $0.handleDeepLink(scene: scene, urlContexts: urlContexts) }
    }
    
    func handleDeepLink(scene: UIScene, userActivity: NSUserActivity) {
        providers.forEach { $0.handleDeepLink(scene: scene, userActivity: userActivity) }
    }
    
    private func handleDeepLinkReceived(deepLink: DeepLink) {
        if let onDeeplinkReceived {
            onDeeplinkReceived(deepLink)
        } else {
            buffer = deepLink
        }
    }
}
