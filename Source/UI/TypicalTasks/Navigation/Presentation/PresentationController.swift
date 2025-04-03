final class PresentationController: HostingController<PresentationView> {
    init(viewModel: PresentationViewModel) {
        super.init(rootView: PresentationView(viewModel: viewModel))
    }
}
