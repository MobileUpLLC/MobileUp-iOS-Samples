import UIKit

final class ToastExampleController: HostingController<ToastExampleView> {
    init(viewModel: ToastExampleViewModel) {
        super.init(rootView: ToastExampleView(viewModel: viewModel))
    }
}
