import UIKit
import TipKit
import SnapKit

@available(iOS 17.0, *)
final class OnboardingWithElementFocusController: HostingController<OnboardingWithElementFocusView> {
    private let favoritesTip = FavoritesTip()

    private lazy var tipView = TipUIView(favoritesTip, arrowEdge: .trailing) { [weak self] action in
        if action.id == "add-to-favorites" {
            self?.addToFavoritesTipButtonTapped()
        } else if action.id == "learn-more" {
            self?.learnMoreTipButtonTapped()
        }
    }

    private let notificationTip = NotificationTip()

    private var favoriteTipObservationTask: Task<Void, Never>?
    private var notificationTipObservationTask: Task<Void, Never>?

    private lazy var favoritesBarButtonItem: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "star")
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(handleTapOnFavoritesRightItem), for: .touchUpInside)
        return button
    }()

    private lazy var notificationRightItemView: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "bell")
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(handleTapOnNotificationRightItem), for: .touchUpInside)
        return button
    }()

    init(viewModel: OnboardingWithElementFocusViewModel) {
        super.init(rootView: OnboardingWithElementFocusView(viewModel: viewModel))

        navigationBarItem = NavigationBarItem(
            rightItems: [
                NavigationBarSideItem(type: .customView(favoritesBarButtonItem)),
                NavigationBarSideItem(type: .customView(notificationRightItemView))
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

    private func addToFavoritesTipButtonTapped() {
        print("Добавить в избранное")
    }

    private func learnMoreTipButtonTapped() {
        print("Узнать больше")
    }

    private func handleFavoritesTipDisplayUpdates() {
        favoriteTipObservationTask = Task { @MainActor in
            for await shouldDisplay in favoritesTip.shouldDisplayUpdates {
                try? Task.checkCancellation()

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
                try? Task.checkCancellation()

                if shouldDisplay {
                    let controller = TipUIPopoverViewController(
                        notificationTip,
                        sourceItem: notificationRightItemView
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
        UIView.animate(withDuration:  0.1) {
            self.favoritesBarButtonItem.tintColor = .gray
        } completion: { _ in
            self.favoritesBarButtonItem.tintColor = nil
        }

        FavoritesTip.favoritesButtonTapped.sendDonation()
        handleFavoritesTipDisplayUpdates()
    }

    @objc private func handleTapOnNotificationRightItem() {
        UIView.animate(withDuration:  0.1) {
            self.notificationRightItemView.tintColor = .gray
        } completion: { _ in
            self.notificationRightItemView.tintColor = nil
        }
    }
}
