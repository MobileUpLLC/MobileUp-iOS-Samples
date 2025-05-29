import UIKit

final class SplashController: HostingController<SplashView> {
    init(viewModel: SplashViewModel) {
        super.init(rootView: SplashView(viewModel: viewModel))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        rootView.viewModel.handleViewAppear()
    }
}
