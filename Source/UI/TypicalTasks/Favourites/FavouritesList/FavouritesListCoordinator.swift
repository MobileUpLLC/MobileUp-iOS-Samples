final class FavouritesListCoordinator {
    weak var router: NavigationRouter?
    
    func showFavouritesDetail(imageId: String) {
        let controller = FavouritesDetailFactory.createFavouritesDetailController(imageId: imageId)
        
        router?.push(controller: controller, isAnimated: true)
    }
}
