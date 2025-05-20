final class FavouritesListCoordinator {
    weak var router: (NavigationRouter & ToastRouter)?
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func showFavouritesDetail(imageId: String) {
        let controller = FavouritesDetailFactory.createFavouritesDetailController(
            networkService: networkService,
            imageId: imageId
        )
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showErrorToast(message: String) {
        router?.showErrorToast(with: message)
    }
}
