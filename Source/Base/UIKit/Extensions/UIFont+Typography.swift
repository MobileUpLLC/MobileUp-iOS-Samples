import UIKit

extension UIFont {
    enum Heading {
        static let primary = UIFont.systemFont(ofSize: 34, weight: .semibold)
        static let secondary = UIFont.systemFont(ofSize: 24, weight: .semibold)
        static let medium = UIFont.systemFont(ofSize: 17, weight: .medium)
        static let small = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
    
    enum Button {
        static let primary = UIFont.systemFont(ofSize: 17, weight: .medium)
        static let small = UIFont.systemFont(ofSize: 13, weight: .medium)
    }
    
    enum Body {
        static let primary = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let secondary = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
    
    enum Caption {
        static let veryLarge = UIFont.systemFont(ofSize: 34, weight: .light)
        static let large = UIFont.systemFont(ofSize: 24, weight: .light)
        static let bigSemiBold = UIFont.systemFont(ofSize: 13, weight: .semibold)
        static let medium = UIFont.systemFont(ofSize: 13, weight: .medium)
        static let small = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
}
