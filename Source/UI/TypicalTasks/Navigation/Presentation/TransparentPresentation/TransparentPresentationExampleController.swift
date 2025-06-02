final class TransparentPresentationExampleController: HostingController<TransparentPresentationExampleView> {
    init(viewModel: TransparentPresentationExampleViewModel) {
        super.init(rootView: TransparentPresentationExampleView(viewModel: viewModel))
    }
}
