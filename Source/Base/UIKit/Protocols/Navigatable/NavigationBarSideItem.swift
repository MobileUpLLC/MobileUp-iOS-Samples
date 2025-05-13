import UIKit

struct NavigationBarSideItem {
    enum ItemType {
        case icon(UIImage)
        case back
        case empty
        case customView(UIView)
    }

    let type: ItemType
    let isEnabled: Bool
    let onTapAction: Closure.Void?

    init(type: ItemType, isEnabled: Bool = true, onTapAction: Closure.Void? = nil) {
        self.type = type
        self.onTapAction = onTapAction
        self.isEnabled = isEnabled
    }
}
