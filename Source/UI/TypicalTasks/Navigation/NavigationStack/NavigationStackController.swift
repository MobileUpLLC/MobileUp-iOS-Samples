final class NavigationStackController: HostingController<NavigationStackView> {
    init(viewModel: NavigationStackViewModel) {
        super.init(rootView: NavigationStackView(viewModel: viewModel))
    }
}
