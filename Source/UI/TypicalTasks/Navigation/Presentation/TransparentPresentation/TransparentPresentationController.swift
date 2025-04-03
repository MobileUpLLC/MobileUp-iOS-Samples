final class TransparentPresentationController: HostingController<TransparentPresentationView> {
    init(viewModel: TransparentPresentationViewModel) {
        super.init(rootView: TransparentPresentationView(viewModel: viewModel))
    }
}
