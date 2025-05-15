final class StarscreamChatController: HostingController<StarscreamChatView> {
    init(viewModel: StarscreamChatViewModel) {
        super.init(rootView: StarscreamChatView(viewModel: viewModel))
        
        view.backgroundColor = .white
    }
}
