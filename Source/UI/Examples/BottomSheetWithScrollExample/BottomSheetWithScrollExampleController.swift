final class BottomSheetWithScrollExampleController: HostingController<BottomSheetWithScrollExampleView> {
    init(viewModel: BottomSheetWithScrollExampleViewModel) {
        super.init(rootView: BottomSheetWithScrollExampleView(viewModel: viewModel))
    }
}
