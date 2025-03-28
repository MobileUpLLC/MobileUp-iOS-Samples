import UIKit

struct NavigationBarCentralItem {
    enum ItemType {
        case title(String)
        case customView(UIView)
        case empty
    }

    let type: ItemType
    var isLayoutWithAnimation = false
    var onTapAction: Closure.Void?
}
