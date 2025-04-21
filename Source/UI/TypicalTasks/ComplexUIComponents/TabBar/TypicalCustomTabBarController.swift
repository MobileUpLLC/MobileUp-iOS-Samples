import UIKit
import TabBarController

protocol TypicalCustomTabBarItemProvider: UIViewController {
    var tabBarItemIcon: UIImage { get set }
}

final class TypicalCustomTabBarController: TabBarController {
    override var controllers: [UIViewController] { tabControllers }
    override var tabBarView: UIView { customTabBarView }

    private lazy var customTabBarView: TypicalTabBarView = {
        let icons = tabControllers.map { $0.tabBarItemIcon }
        let view = TypicalTabBarView(icons: icons)
        
        view.onItemSelect = { [weak self] index in
            self?.selectedIndex = index
        }
        
        return view
    }()
    
    private let viewModel: TypicalTabBarViewModel
    private let tabControllers: [TypicalCustomTabBarItemProvider]
    
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
    
    init(
        viewModel: TypicalTabBarViewModel,
        controllers: [TypicalCustomTabBarItemProvider]
    ) {
        self.viewModel = viewModel
        self.tabControllers = controllers
        
        super.init(nibName: nil, bundle: nil)
    }
}

extension UIViewController {
    var typicalCustomTabBarController: TypicalCustomTabBarController? {
        findParent(type: TypicalCustomTabBarController.self)
    }
}

extension UINavigationController: TypicalCustomTabBarItemProvider {
   var typicalTabBarItemIcon: UIImage {
       get { rootController?.tabBarItemIcon ?? UIImage() }
       set { rootController?.tabBarItemIcon = newValue }
   }
              
   private var rootController: TypicalCustomTabBarItemProvider? {
       return viewControllers.first as? TypicalCustomTabBarItemProvider
   }
}
