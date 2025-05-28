final class ComplexUIComponentsController: HostingController<ComplexUIComponentsView> {
    override var isTabBarHidden: Bool { true }
    
    init(viewModel: ComplexUIComponentsViewModel) {
        super.init(rootView: ComplexUIComponentsView(viewModel: viewModel))
    }
}
