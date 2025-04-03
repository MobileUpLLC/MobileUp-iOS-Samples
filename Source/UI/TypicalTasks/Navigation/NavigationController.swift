final class NavigationController: HostingController<NavigationView> {
    init(viewModel: NavigationViewModel) {
        super.init(rootView: NavigationView(viewModel: viewModel))
    }
}
