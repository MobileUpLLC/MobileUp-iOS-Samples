final class FavouritesListCoordinator {
    weak var router: (NavigationRouter & ToastRouter)?
    private let networkService: NetworkService
    private let likeService: LikeService

    init(networkService: NetworkService, likeService: LikeService) {
        self.networkService = networkService
        self.likeService = likeService
    }
    
    func showFavouritesDetail(imageId: String) {
        let controller = FavouritesDetailFactory.createFavouritesDetailController(
            networkService: networkService,
            likeService: likeService,
            imageId: imageId
        )
        
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showErrorToast(message: String) {
        router?.showToast(
            with: ToastItem(
                viewItem: ToastViewItem(
                    style: .failure,
                    message: message,
                    leftIcon: nil,
                    rightIcon: .checkmark
                ),
                toastType: .global,
                direction: .bottom,
                duration: .one,
                isHideOnTap: true,
                onTap: {}
            )
        )
    }
}
