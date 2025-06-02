final class NativeChatController: HostingController<NativeChatView> {
    override var isTabBarHidden: Bool { true }
    
    init(viewModel: NativeChatViewModel) {
        super.init(rootView: NativeChatView(viewModel: viewModel))
        
        view.backgroundColor = .white
    }
}
