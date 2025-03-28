import SwiftUI

class HostingController<T: View>: UIHostingController<T>, Navigatable {
    var navigationBarItem: NavigationBarItem = .default { didSet { configureNavigationBar() } }
    var isBackButtonHidden: Bool { false }
    var isNavigationBarHidden: Bool { false }
    var isTabBarHidden: Bool { false }
    
    override init(rootView: T) {
        super.init(rootView: rootView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBarVisibility()
        customTabBarController?.setTabBarViewVisibility(isHidden: isTabBarHidden)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        
        // сделано так исключительно для простоты работы с логами,
        // без накручивания доп логики на разных экранах
        if motion == .motionShake, Environments.isRelease == false {
            let logsController = LogsFactory.createLogsController()
            
            present(logsController, animated: true)
        }
    }
    
    @available(*, unavailable) @MainActor dynamic required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
