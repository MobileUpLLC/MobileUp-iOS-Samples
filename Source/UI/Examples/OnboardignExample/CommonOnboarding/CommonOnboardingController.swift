import UIKit

final class CommonOnboardingController: HostingController<CommonOnboardingView> {
    init(viewModel: CommonOnboardingViewModel) {
        super.init(rootView: CommonOnboardingView(viewModel: viewModel))
        
        navigationBarItem = .init(
            rightItems: [
                .init(type: .icon(R.image.ic24.cancel.asUIImage), onTapAction: viewModel.handleCloseButtonTap)
            ],
            foregroundColor: .white
        )
    }
}
