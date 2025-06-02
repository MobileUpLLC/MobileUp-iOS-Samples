final class StarscreamChatController: HostingController<StarscreamChatView> {
    override var isTabBarHidden: Bool { true }
    
    init(viewModel: StarscreamChatViewModel) {
        super.init(rootView: StarscreamChatView(viewModel: viewModel))
        
        view.backgroundColor = .white
    }
}
