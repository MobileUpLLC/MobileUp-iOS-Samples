final class FavouritesDetailController: HostingController<FavouritesDetailView> {
    init(viewModel: FavouritesDetailViewModel) {
        super.init(rootView: FavouritesDetailView(viewModel: viewModel))
    }
}
