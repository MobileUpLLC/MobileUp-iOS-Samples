final class FavouritesDetailCoordinator {
    weak var router: (NavigationRouter & ToastRouter)?
    
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
