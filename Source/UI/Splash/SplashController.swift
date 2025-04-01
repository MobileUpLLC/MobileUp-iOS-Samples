import UIKit

final class SplashController: HostingController<SplashView> {
    init(viewModel: SplashViewModel) {
        super.init(rootView: SplashView(viewModel: viewModel))
    }
}
