import UIKit

protocol Navigatable {
    var navigationBarItem: NavigationBarItem { get }
    var isNavigationBarHidden: Bool { get }
    var isBackButtonHidden: Bool { get }
    
    func configureNavigationBar()
}

extension Navigatable where Self: UIViewController {
    func configureNavigationBar() {
        configureNavigationBarCentralItem()
        configureNavigationBarLeftItem()
        configureNavigationBarRightItems()
    }

    func configureNavigationBarVisibility() {
        navigationController?.navigationBar.isHidden = isNavigationBarHidden
        navigationItem.setHidesBackButton(isBackButtonHidden, animated: false)
    }

    private func configureNavigationBarCentralItem() {
        navigationController?.navigationBar.tintColor = navigationBarItem.foregroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = navigationBarItem.isLargeTitle ? .always : .never
        configureToolbarItem()
    }
    
    private func configureToolbarItem() {
        if navigationBarItem.isLargeTitle {
            configureLargeTitleIfNeeded()
        } else {
            navigationItem.titleView = NavigationBarCentralItemView(item: navigationBarItem.centralItem)
        }
    }

    private func configureNavigationBarLeftItem() {
        navigationItem.backButtonDisplayMode = .minimal

        switch navigationBarItem.leftItem.type {
        case let .icon(icon):
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: icon,
                style: .plain,
                target: self,
                action: #selector(handleTapOnNavigationBarLeftItem)
            )
        case .back:
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: R.image.ic24.arrow.asUIImage,
                style: .plain,
                target: self,
                action: #selector(handleTapOnNavigationBarLeftItem)
            )
        case .empty, .button:
            navigationItem.leftBarButtonItem = .none
            navigationItem.hidesBackButton = true
        case let .customView(view):
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
        }

        navigationItem.leftBarButtonItem?.isEnabled = navigationBarItem.leftItem.isEnabled
    }

    private func configureNavigationBarRightItems() {
        var rightBarButtonItems: [UIBarButtonItem] = []

        for index in navigationBarItem.rightItems.indices {
            let item = navigationBarItem.rightItems[index]

            switch item.type {
            case .icon(let icon):
                let newBarButtonItem = UIBarButtonItem(
                    image: icon,
                    style: .plain,
                    target: self,
                    action: #selector(handleTapOnNavigationRightItem)
                )
                newBarButtonItem.isEnabled = item.isEnabled
                newBarButtonItem.tag = index
                rightBarButtonItems.append(newBarButtonItem)
            case .empty, .back:
                break
            case let .customView(view):
                let newBarButtonItem = UIBarButtonItem(customView: view)
                newBarButtonItem.isEnabled = item.isEnabled
                rightBarButtonItems.append(newBarButtonItem)
            case .button(let button):
                button.isEnabled = item.isEnabled
                button.tag = index
                rightBarButtonItems.append(button)
            }
        }

        navigationItem.rightBarButtonItems = rightBarButtonItems
    }

    private func configureLargeTitleIfNeeded() {
        if case .title(let title) = navigationBarItem.centralItem.type {
            navigationItem.title = title
        } else {
            navigationItem.title = nil
        }
    }
}

fileprivate extension UIViewController {
    @objc func handleTapOnNavigationBarLeftItem() {
        guard let self = self as? Navigatable else {
            return
        }

        switch self.navigationBarItem.leftItem.type {
        case .icon, .empty, .customView, .button:
            break
        case .back:
            navigationController?.popViewController(animated: true)
        }

        self.navigationBarItem.leftItem.onTapAction?()
    }

    @objc func handleTapOnNavigationRightItem(_ sender: UITabBarItem) {
        guard let self = self as? Navigatable else {
            return
        }

        self.navigationBarItem.rightItems[sender.tag].onTapAction?()
    }
}
