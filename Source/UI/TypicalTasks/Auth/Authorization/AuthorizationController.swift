import UIKit

final class AuthorizationController: HostingController<AuthorizationView> {
    override var isTabBarHidden: Bool { true }
    
    init(viewModel: AuthorizationViewModel) {
        super.init(rootView: AuthorizationView(viewModel: viewModel))
        
        navigationBarItem = NavigationBarItem(
            centralItem: .init(type: .title(R.string.auth.authorizationNavigationBarTitle())),
            isLargeTitle: true
        )
    }
}
