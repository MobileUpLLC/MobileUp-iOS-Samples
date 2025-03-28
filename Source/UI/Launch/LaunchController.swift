final class LaunchController: HostingController<LaunchView> {
    init(viewModel: LaunchViewModel) {
        super.init(rootView: LaunchView(viewModel: viewModel))
    }
}
