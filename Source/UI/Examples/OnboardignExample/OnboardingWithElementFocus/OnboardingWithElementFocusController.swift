import UIKit
import TipKit
import SnapKit

final class OnboardingWithElementFocusController: HostingController<OnboardingWithElementFocusView> {
    private let favoritesTip = FavoritesTip()
    private lazy var tipView = TipUIView(favoritesTip, arrowEdge: .trailing)

    private let notificationTip = NotificationTip()

    private var favoriteTipObservationTask: Task<Void, Never>?
    private var notificationTipObservationTask: Task<Void, Never>?

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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        favoriteTipObservationTask?.cancel()
        favoriteTipObservationTask = nil

        notificationTipObservationTask?.cancel()
        notificationTipObservationTask = nil
    }

    private func handleFavoritesTipDisplayUpdates() {
        favoriteTipObservationTask = Task { @MainActor in
            for await shouldDisplay in favoritesTip.shouldDisplayUpdates {
                if shouldDisplay {
                    view.addSubview(tipView)

                    tipView.snp.makeConstraints {
                        $0.top.equalToSuperview().inset(150)
                        $0.horizontalEdges.equalToSuperview().inset(16)
                    }
                } else if view.subviews.contains(tipView) {
                    NotificationTip.hasViewedFavoritesTip = true
                    tipView.removeFromSuperview()
                }
            }
        }
    }

    private func handleNotificationTipDisplayUpdates() {
        notificationTipObservationTask = Task { @MainActor in
            for await shouldDisplay in notificationTip.shouldDisplayUpdates {
                if shouldDisplay {
                    let controller = TipUIPopoverViewController(
                        notificationTip,
                        sourceItem: notificationBarButtonItem
                    )
                    controller.view.backgroundColor = .clear
                    controller.viewStyle = NotificationTipViewStyle()

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
