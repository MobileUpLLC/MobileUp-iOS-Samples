import UIKit

final class ConfirmationCodeController: HostingController<ConfirmationCodeView> {
    init(viewModel: ConfirmationCodeViewModel) {
        super.init(rootView: ConfirmationCodeView(viewModel: viewModel))
    }
}
