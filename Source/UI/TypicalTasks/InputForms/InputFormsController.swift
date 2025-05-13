final class InputFormsController: HostingController<InputFormsView> {
    init(viewModel: InputFormsViewModel) {
        super.init(rootView: InputFormsView(viewModel: viewModel))
    }
}
