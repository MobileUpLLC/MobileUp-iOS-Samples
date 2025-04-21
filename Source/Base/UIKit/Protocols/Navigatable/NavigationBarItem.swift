import UIKit

struct NavigationBarItem {
    static let `default` = Self()

    let centralItem: NavigationBarCentralItem
    let leftItem: NavigationBarSideItem
    let rightItems: [NavigationBarSideItem]
    let isLargeTitle: Bool
    let foregroundColor: UIColor

    init(
        centralItem: NavigationBarCentralItem = NavigationBarCentralItem(type: .empty),
        leftItem: NavigationBarSideItem = NavigationBarSideItem(type: .empty),
        rightItems: [NavigationBarSideItem] = [],
        isLargeTitle: Bool = false,
        foregroundColor: UIColor = R.color.icon.iconPrimary.asUIColor
    ) {
        self.centralItem = centralItem
        self.leftItem = leftItem
        self.rightItems = rightItems
        self.isLargeTitle = isLargeTitle
        self.foregroundColor = foregroundColor
    }
}
