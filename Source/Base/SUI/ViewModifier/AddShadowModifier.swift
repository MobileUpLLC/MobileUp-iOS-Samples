import SwiftUI

extension View {
    func addDefaultShadow(opacity: Double, radius: CGFloat, x: CGFloat, y: CGFloat) -> some View {
        modifier(AddShadowModifier(opacity: opacity, radius: radius, x: x, y: y))
    }
}

struct AddShadowModifier: ViewModifier {
    let opacity: Double
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(opacity), radius: radius, x: x, y: y)
    }
}
