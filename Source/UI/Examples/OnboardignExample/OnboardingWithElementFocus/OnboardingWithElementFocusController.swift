import UIKit

final class OnboardingWithElementFocusController: HostingController<OnboardingWithElementFocusView> {
    init(viewModel: OnboardingWithElementFocusViewModel) {
        super.init(rootView: OnboardingWithElementFocusView(viewModel: viewModel))
    }
}
