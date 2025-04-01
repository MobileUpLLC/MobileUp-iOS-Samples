import UIKit

final class AuthorizationController: HostingController<AuthorizationView> {
    init(viewModel: AuthorizationViewModel) {
        super.init(rootView: AuthorizationView(viewModel: viewModel))
    }
}
