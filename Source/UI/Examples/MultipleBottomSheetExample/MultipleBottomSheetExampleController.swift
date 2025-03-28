final class MultipleBottomSheetExampleController: HostingController<MultipleBottomSheetExampleView> {
    init(viewModel: MultipleBottomSheetExampleViewModel) {
        super.init(rootView: MultipleBottomSheetExampleView(viewModel: viewModel))
    }
}
