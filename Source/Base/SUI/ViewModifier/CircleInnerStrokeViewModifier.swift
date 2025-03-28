import SwiftUI

// добавляет border в виде окружности к view
extension View {
    func circleStrokeIfNeeded(color: Color?, lineWidth: CGFloat = 1) -> some View {
        modifier(CircleInnerStrokeViewModifier(color: color, lineWidth: lineWidth))
    }
}

private struct CircleInnerStrokeViewModifier: ViewModifier {
    let color: Color?
    let lineWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if let color {
                    Circle()
                        .strokeBorder(color, lineWidth: lineWidth)
                }
            }
    }
}
