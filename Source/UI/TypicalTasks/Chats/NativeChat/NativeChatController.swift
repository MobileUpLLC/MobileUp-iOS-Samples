final class NativeChatController: HostingController<NativeChatView> {
    init(viewModel: NativeChatViewModel) {
        super.init(rootView: NativeChatView(viewModel: viewModel))
        
        view.backgroundColor = .white
    }
}
