final class FileUploadController: HostingController<FileUploadView> {
    init(viewModel: FileUploadViewModel) {
        super.init(rootView: FileUploadView(viewModel: viewModel))
    }
}
