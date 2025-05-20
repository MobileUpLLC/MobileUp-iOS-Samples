enum FavouritesListFactory {
    static func createFavouritesListController(networkService: NetworkService) -> FavouritesListController {
        let coordinator = FavouritesListCoordinator(networkService: networkService)
        let postRepository = PostRepository(networkService: networkService)
        let viewModel = FavouritesListViewModel(
            coordinator: coordinator,
            postRepository: postRepository
        )
        let controller = FavouritesListController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
