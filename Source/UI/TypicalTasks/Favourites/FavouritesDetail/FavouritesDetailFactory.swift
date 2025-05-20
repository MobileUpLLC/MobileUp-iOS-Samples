enum FavouritesDetailFactory {
    static func createFavouritesDetailController(
        likeService: LikeService,
        imageId: String
    ) -> FavouritesDetailController {
        let coordinator = FavouritesDetailCoordinator()
        let dataStorage = DataStorageService<[PostModel]>()
        let postRepository = PostRepository(dataStorage: dataStorage)
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
