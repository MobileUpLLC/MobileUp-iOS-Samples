import UIKit

final class NetworkExampleController: HostingController<NetworkExampleView> {
    init(viewModel: NetworkExampleViewModel) {
        super.init(rootView: NetworkExampleView(viewModel: viewModel))
        
        view.backgroundColor = .white
    }
}
