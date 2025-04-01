import UIKit

final class EntranceController: HostingController<EntranceView> {
    init(viewModel: EntranceViewModel) {
        super.init(rootView: EntranceView(viewModel: viewModel))
    }
}
