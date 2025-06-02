import SwiftUI

extension View {
    func wrappedInScrollView() -> some View {
        modifier(ScrollableModifier())
    }
}

private struct ScrollableModifier: ViewModifier {
    func body(content: Content) -> some View {
        ViewThatFits(in: .vertical) {
            content
            ScrollView(.vertical) {
                content
            }
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
        }
    }
}
