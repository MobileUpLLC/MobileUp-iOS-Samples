final class ToastExampleCoordinator {
    weak var router: ToastRouter?

    func showGlobalToast() {
        router?.showToast(
            with: ToastItem(
                viewItem: ToastViewItem(
                    style: .information,
                    message: "It is global toast",
                    leftIcon: nil,
                    rightIcon: .checkmark
                ),
                toastType: .global,
                direction: .bottom,
                duration: .five,
                isHideOnTap: true,
                onTap: {}
            )
        )
    }

    func showLocalToast() {
        router?.showErrorToast(with: "It is local error toast")
    }
}
