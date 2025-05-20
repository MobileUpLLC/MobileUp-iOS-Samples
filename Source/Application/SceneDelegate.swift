import UIKit
import munkit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private enum Constants {
        static let postsStorageKey = "Posts"
        static let postsMockFileName = "MockPosts"
    }
    
    var window: UIWindow?
    private var networkService: NetworkService?

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

        let networkService = NetworkService(
            session: .defaultWithoutCache,
            plugins: [MUNLoggerPlugin.instance]
        )
        self.networkService = networkService

        Task {
            window?.rootViewController = await SplashFactory.createSplashController(
                networkService: networkService,
                completion: { [weak self] flow in
                    self?.updateWindow(with: flow)
                }
            )
        }
        
        if let userActivity = connectionOptions.userActivities.first {
            DeepLinkService.shared.handleDeepLink(scene: scene, userActivity: userActivity)
        } else if connectionOptions.urlContexts.isEmpty == false {
            DeepLinkService.shared.handleDeepLink(scene: scene, urlContexts: connectionOptions.urlContexts)
        }
        
        setupPosts()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        DeepLinkService.shared.handleDeepLink(scene: scene, urlContexts: URLContexts)
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        DeepLinkService.shared.handleDeepLink(scene: scene, userActivity: userActivity)
    }
    
    private func updateWindow(with flow: InitialNavigationFlow) {
        guard let window else {
            return
        }
        guard let networkService else {
            return
        }

        window.rootViewController = TypicalTasksFactory.createTypicalTasksController(networkService: networkService)
    }
    
    private func setupPosts() {
        let dataStorageService = DataStorageService<[PostModel]>()
        let decoder = JSONDecoder()
        
        guard
            let url = Bundle.main.url(forResource: Constants.postsMockFileName, withExtension: "json"),
            let jsonData = try? Data(contentsOf: url),
            let posts = try? decoder.decode([PostModel].self, from: jsonData)
        else {
            return
        }
        
        try? dataStorageService.setObject(posts, forKey: Constants.postsStorageKey, expiry: .never)
    }
}
