enum FavouritesDetailFactory {
    static func createFavouritesDetailController(
        networkService: NetworkService,
        likeService: LikeService,
        imageId: String
    ) -> FavouritesDetailController {
        let coordinator = FavouritesDetailCoordinator()
        let postRepository = PostRepository(networkService: networkService)
        let viewModel = FavouritesDetailViewModel(
            coordinator: coordinator,
            postRepository: postRepository,
            likeService: likeService,
            imageId: imageId
        )
        let controller = FavouritesDetailController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
