import UIKit
import TipKit
import SnapKit

@available(iOS 17.0, *)
final class OnboardingWithElementFocusController: HostingController<OnboardingWithElementFocusView> {
    let profileTip = FavoritesTip()

    lazy var favoritesBarButtonItem: UIBarButtonItem = {
        let newBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(handleTapOnNavigationRightItem)
        )
        return newBarButtonItem
    }()

    init(viewModel: OnboardingWithElementFocusViewModel) {
        super.init(rootView: OnboardingWithElementFocusView(viewModel: viewModel))
        
        navigationBarItem = .init(
            rightItems: [
                .init(type: .button(favoritesBarButtonItem))
            ]
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        handleTipDisplayUpdates()
    }

    private func handleTipDisplayUpdates() {
        Task { @MainActor in
            for await shouldDisplay in profileTip.shouldDisplayUpdates {
                if shouldDisplay {
                    let controller = TipUIPopoverViewController(
                        profileTip,
                        sourceItem: favoritesBarButtonItem
                    ) { action in
                        if action.id == "add-to-favorites" {
                            print("Добавить в избранное")
                        }

                        if action.id == "learn-more" {
                            print("Узнать больше")
                        }
                    }
                    controller.view.backgroundColor = .clear
                    controller.viewStyle = CustomTipViewStyle()

                    self.present(controller, animated: true)
                } else if presentedViewController is TipUIPopoverViewController {
                    dismiss(animated: true)
                }
            }
        }
    }

    @objc func handleTapOnNavigationRightItem() {
        FavoritesTip.profileButtonTapped.sendDonation()
    }
}
