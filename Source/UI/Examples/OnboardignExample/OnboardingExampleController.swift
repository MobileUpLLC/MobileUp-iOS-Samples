import UIKit

final class OnboardingExampleController: HostingController<OnboardingExampleView> {
    init(viewModel: OnboardingExampleViewModel) {
        super.init(rootView: OnboardingExampleView(viewModel: viewModel))
        
        navigationBarItem = .init(centralItem: .init(type: .title(R.string.examples.onboardingNavigationBarTitle())))
    }
}
