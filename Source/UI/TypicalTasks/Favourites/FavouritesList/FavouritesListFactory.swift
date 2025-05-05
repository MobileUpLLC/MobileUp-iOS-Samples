enum FavouritesListFactory {
    static func createFavouritesListController() -> FavouritesListController {
        let coordinator = FavouritesListCoordinator()
        let publicationRepository = PublicationRepository()
        let viewModel = FavouritesListViewModel(
            coordinator: coordinator,
            publicationRepository: publicationRepository
        )
        let controller = FavouritesListController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
