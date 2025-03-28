import SwiftUI

extension View {
    func onDragGestureTranslation(
        onChange: Closure.Generic<CGSize>? = nil,
        onEnded: @escaping Closure.Generic<CGSize>
    ) -> some View {
        modifier(OnDragGestureTranslationModifier(onChange: onChange, onEnded: onEnded))
    }
}

private struct OnDragGestureTranslationModifier: ViewModifier {
    let onChange: Closure.Generic<CGSize>?
    let onEnded: Closure.Generic<CGSize>
    
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture()
                    .onChanged { onChange?($0.translation) }
                    .onEnded { onEnded($0.predictedEndTranslation) }
            )
    }
}
