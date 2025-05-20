enum FavouritesListFactory {
    static func createFavouritesListController(networkService: NetworkService) -> FavouritesListController {
        let likeService = LikeService()
        let coordinator = FavouritesListCoordinator(networkService: networkService, likeService: likeService)
        let postRepository = PostRepository(networkService: networkService)
        let viewModel = FavouritesListViewModel(
            coordinator: coordinator,
            postRepository: postRepository,
            likeService: likeService
        )
        let controller = FavouritesListController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
