final class DataTransferController: HostingController<DataTransferView> {
    init(viewModel: DataTransferViewModel) {
        super.init(rootView: DataTransferView(viewModel: viewModel))
    }
}
