final class PresentationExampleController: HostingController<PresentationExampleView> {
    init(viewModel: PresentationExampleViewModel) {
        super.init(rootView: PresentationExampleView(viewModel: viewModel))
    }
}
