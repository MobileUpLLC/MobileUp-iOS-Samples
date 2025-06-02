final class StorageController: HostingController<StorageView> {
    init(viewModel: StorageViewModel) {
        super.init(rootView: StorageView(viewModel: viewModel))
    }
}
