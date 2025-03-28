import UIKit
import SwiftUI

extension UIFont {
    var asFont: Font { Font(self as CTFont) }
}
