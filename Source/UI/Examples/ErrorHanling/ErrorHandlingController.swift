final class ErrorHandlingController: HostingController<ErrorHandlingView> {
    init(viewModel: ErrorHandlingViewModel) {
        super.init(rootView: ErrorHandlingView(viewModel: viewModel))
    }
}
