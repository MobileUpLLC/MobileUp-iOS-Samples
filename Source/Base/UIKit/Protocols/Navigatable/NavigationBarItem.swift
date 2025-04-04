struct NavigationBarItem {
    static let `default` = Self()

    let centralItem: NavigationBarCentralItem
    let leftItem: NavigationBarSideItem
    let rightItems: [NavigationBarSideItem]
    let isLargeTitle: Bool

    init(
        centralItem: NavigationBarCentralItem = NavigationBarCentralItem(type: .empty),
        leftItem: NavigationBarSideItem = NavigationBarSideItem(type: .empty),
        rightItems: [NavigationBarSideItem] = [],
        isLargeTitle: Bool = false
    ) {
        self.centralItem = centralItem
        self.leftItem = leftItem
        self.rightItems = rightItems
        self.isLargeTitle = isLargeTitle
    }
}
