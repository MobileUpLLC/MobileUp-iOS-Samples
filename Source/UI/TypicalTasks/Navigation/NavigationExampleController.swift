final class NavigationExampleController: HostingController<NavigationExampleView> {
    init(viewModel: NavigationExampleViewModel) {
        super.init(rootView: NavigationExampleView(viewModel: viewModel))
    }
}
