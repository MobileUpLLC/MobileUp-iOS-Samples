final class ChatsController: HostingController<ChatsView> {
    init(viewModel: ChatsViewModel) {
        super.init(rootView: ChatsView(viewModel: viewModel))
        
        view.backgroundColor = .white
    }
}
