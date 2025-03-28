import UIKit
import TabBarController

protocol CustomTabBarItemProvider: UIViewController {
    var tabBarItemIcon: UIImage { get set }
}

final class CustomTabBarController: TabBarController {
    override var controllers: [UIViewController] { tabControllers }
    override var tabBarView: UIView { customTabBarView }

    private lazy var customTabBarView: TabBarView = {
        let icons = tabControllers.map { $0.tabBarItemIcon }
        let view = TabBarView(icons: icons)
        
        view.onItemSelect = { [weak self] index in
            self?.selectedIndex = index
        }
        
        return view
    }()
    
    private let viewModel: TabbarViewModel
    private let tabControllers: [CustomTabBarItemProvider]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tabBarView)
        
        tabBarView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    override func selectedIndexDidChange() {
        super.selectedIndexDidChange()
        
        customTabBarView.selectedIndex = selectedIndex
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
    
    init(
        viewModel: TabbarViewModel,
        controllers: [CustomTabBarItemProvider]
    ) {
        self.viewModel = viewModel
        self.tabControllers = controllers
        
        super.init(nibName: nil, bundle: nil)
    }
}

extension UIViewController {
    var customTabBarController: CustomTabBarController? {
        findParent(type: CustomTabBarController.self)
    }
}

extension UINavigationController: CustomTabBarItemProvider {
   var tabBarItemIcon: UIImage {
       get { rootController?.tabBarItemIcon ?? UIImage() }
       set { rootController?.tabBarItemIcon = newValue }
   }
              
   private var rootController: CustomTabBarItemProvider? {
       return viewControllers.first as? CustomTabBarItemProvider
   }
}
