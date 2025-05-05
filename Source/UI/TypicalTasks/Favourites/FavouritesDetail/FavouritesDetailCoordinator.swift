final class FavouritesDetailCoordinator {
    weak var router: (NavigationRouter & ToastRouter)?
    
    func showErrorToast(message: String) {
        router?.showErrorToast(with: message)
    }
}
