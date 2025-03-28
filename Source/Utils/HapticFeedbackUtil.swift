import UIKit

enum HapticFeedbackType {
    case selection
    case impact(UIImpactFeedbackGenerator.FeedbackStyle)
    case notification(UINotificationFeedbackGenerator.FeedbackType)
}

enum HapticFeedbackUtil {
    private static let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    private static let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    private static let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    private static let mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    private static let heavyImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private static let rigidImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
    private static let softImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)

    static func generate(_ type: HapticFeedbackType) {
        switch type {
        case .selection:
            selectionFeedbackGenerator.selectionChanged()
        case .impact(let feedbackStyle):
            generate(impactFeedbackStyle: feedbackStyle)
        case .notification(let feedbackType):
            notificationFeedbackGenerator.notificationOccurred(feedbackType)
        }
    }

    private static func generate(impactFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        switch impactFeedbackStyle {
        case .light:
            lightImpactFeedbackGenerator.impactOccurred()
        case .medium:
            mediumImpactFeedbackGenerator.impactOccurred()
        case .heavy:
            heavyImpactFeedbackGenerator.impactOccurred()
        case .soft:
            softImpactFeedbackGenerator.impactOccurred()
        case .rigid:
            rigidImpactFeedbackGenerator.impactOccurred()
        @unknown default:
            lightImpactFeedbackGenerator.impactOccurred()
        }
    }
}
