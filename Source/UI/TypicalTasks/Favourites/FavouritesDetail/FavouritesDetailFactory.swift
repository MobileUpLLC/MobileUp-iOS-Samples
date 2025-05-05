enum FavouritesDetailFactory {
    static func createFavouritesDetailController(imageId: String) -> FavouritesDetailController {
        let coordinator = FavouritesDetailCoordinator()
        let publicationRepository = PublicationRepository()
        let viewModel = FavouritesDetailViewModel(
            coordinator: coordinator,
            publicationRepository: publicationRepository,
            
            imageId: imageId
        )
        let controller = FavouritesDetailController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
