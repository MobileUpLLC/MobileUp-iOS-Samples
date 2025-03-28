import UIKit

final class URLSchemeDeepLinkProvider: DeepLinkProvider {
    static let shared = URLSchemeDeepLinkProvider()
    
    var onDeeplinkReceived: Utils.Closure.Generic<DeepLink>?
    
    private init() {}
    
    func configure(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) { }
    
    func handleDeepLink(scene: UIScene, urlContexts: Set<UIOpenURLContext>) {
        guard let url = urlContexts.first?.url else {
            return
        }
        
        handleUrl(url)
    }
    
    func handleDeepLink(scene: UIScene, userActivity: NSUserActivity) {
        guard let url = userActivity.webpageURL else {
            return
        }
        
        handleUrl(url)
    }
    
    private func handleUrl(_ url: URL) {
        guard let deeplinkScheme = url.scheme, Environments.deeplinkScheme.contains(deeplinkScheme) else {
            return
        }
        
        // NOTE: Parse url
        onDeeplinkReceived?(.test)
    }
}
