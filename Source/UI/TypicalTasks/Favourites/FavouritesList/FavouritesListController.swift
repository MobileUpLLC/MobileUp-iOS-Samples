final class FavouritesListController: HostingController<FavouritesListView> {
    init(viewModel: FavouritesListViewModel) {
        super.init(rootView: FavouritesListView(viewModel: viewModel))
    }
}
