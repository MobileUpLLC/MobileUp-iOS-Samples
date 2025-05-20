enum FavouritesListFactory {
    static func createFavouritesListController() -> FavouritesListController {
        let likeService = LikeService()
        let coordinator = FavouritesListCoordinator(likeService: likeService)
        let dataStorage = DataStorageService<[PostModel]>()
        let postRepository = PostRepository(dataStorage: dataStorage)
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
