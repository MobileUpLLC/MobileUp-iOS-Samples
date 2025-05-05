final class FavouritesListCoordinator {
    weak var router: (NavigationRouter & ToastRouter)?
    
    func showFavouritesDetail(imageId: String) {
        let controller = FavouritesDetailFactory.createFavouritesDetailController(imageId: imageId)
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showErrorToast(message: String) {
        router?.showErrorToast(with: message)
    }
}
