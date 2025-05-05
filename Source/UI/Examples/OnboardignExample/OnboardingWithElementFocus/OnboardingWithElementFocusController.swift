import UIKit
import TipKit
import SnapKit

@available(iOS 17.0, *)
final class OnboardingWithElementFocusController: HostingController<OnboardingWithElementFocusView> {
    let favoritesTip = FavoritesTip()
    let notificationTip = NotificationTip()

    lazy var favoritesBarButtonItem: UIBarButtonItem = {
        let newBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(handleTapOnFavoritesRightItem)
        )
        return newBarButtonItem
    }()

    lazy var notificationBarButtonItem: UIBarButtonItem = {
        let newBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "bell"),
            style: .plain,
            target: self,
            action: #selector(handleTapOnNotificationRightItem)
        )
        return newBarButtonItem
    }()

    init(viewModel: OnboardingWithElementFocusViewModel) {
        super.init(rootView: OnboardingWithElementFocusView(viewModel: viewModel))
        
        navigationBarItem = .init(
            rightItems: [
                .init(type: .button(favoritesBarButtonItem)),
                .init(type: .button(notificationBarButtonItem))
            ]
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        handleNotificationTipDisplayUpdates()
    }

    private func handleFavoritesTipDisplayUpdates() {
        Task { @MainActor in
            for await shouldDisplay in favoritesTip.shouldDisplayUpdates {
                if shouldDisplay {
                    let controller = TipUIPopoverViewController(
                        favoritesTip,
                        sourceItem: favoritesBarButtonItem
                    )
                    controller.view.backgroundColor = .clear
                    controller.viewStyle = CustomTipViewStyle()

                    present(controller, animated: true)
                } else if presentedViewController is TipUIPopoverViewController {
                    NotificationTip.hasViewedFavoritesTip = true
                    dismiss(animated: true)
                }
            }
        }
    }

    private func handleNotificationTipDisplayUpdates() {
        Task { @MainActor in
            for await shouldDisplay in notificationTip.shouldDisplayUpdates {
                if shouldDisplay {
                    let controller = TipUIPopoverViewController(
                        notificationTip,
                        sourceItem: notificationBarButtonItem
                    )
                    controller.view.backgroundColor = .clear
                    controller.viewStyle = CustomTipViewStyle()

                    present(controller, animated: true)
                } else if presentedViewController is TipUIPopoverViewController {
                    dismiss(animated: true)
                }
            }
        }
    }

    @objc private func handleTapOnFavoritesRightItem() {
        FavoritesTip.favoritesButtonTapped.sendDonation()
        handleFavoritesTipDisplayUpdates()
    }

    @objc private func handleTapOnNotificationRightItem() {}
}
