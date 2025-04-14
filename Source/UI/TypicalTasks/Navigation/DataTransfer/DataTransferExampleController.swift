final class DataTransferExampleController: HostingController<DataTransferExampleView> {
    init(viewModel: DataTransferExampleViewModel) {
        super.init(rootView: DataTransferExampleView(viewModel: viewModel))
    }
}
