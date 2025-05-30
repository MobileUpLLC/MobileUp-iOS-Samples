import UIKit

final class RegistrationController: HostingController<RegistrationView> {
    override var isTabBarHidden: Bool { true }
    
    init(viewModel: RegistrationViewModel) {
        super.init(rootView: RegistrationView(viewModel: viewModel))
        
        navigationBarItem = NavigationBarItem(
            centralItem: .init(type: .title(R.string.auth.registrationNavigationBarTitle())),
            isLargeTitle: true
        )
    }
}
