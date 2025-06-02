final class NavigationStackExampleController: HostingController<NavigationStackExampleView> {
    init(viewModel: NavigationStackExampleViewModel) {
        super.init(rootView: NavigationStackExampleView(viewModel: viewModel))
    }
}
