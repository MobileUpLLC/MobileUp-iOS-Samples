import UIKit.UIColor

struct NavigationBarItem {
    static let `default` = Self()

    let centralItem: NavigationBarCentralItem
    let leftItem: NavigationBarSideItem
    let rightItems: [NavigationBarSideItem]
    let isLargeTitle: Bool
    var background: NavigationBarBackground?
    let foregroundColor: UIColor

    init(
        centralItem: NavigationBarCentralItem = NavigationBarCentralItem(type: .empty),
        leftItem: NavigationBarSideItem = NavigationBarSideItem(type: .empty),
        rightItems: [NavigationBarSideItem] = [],
        isLargeTitle: Bool = false,
        background: NavigationBarBackground? = .color(.systemBackground),
        foregroundColor: UIColor = .black
    ) {
        self.centralItem = centralItem
        self.leftItem = leftItem
        self.rightItems = rightItems
        self.isLargeTitle = isLargeTitle
        self.background = background
        self.foregroundColor = foregroundColor
    }
}
