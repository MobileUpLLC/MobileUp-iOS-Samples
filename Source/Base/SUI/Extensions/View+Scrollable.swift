import SwiftUI

extension View {
    func wrappedInScrollView(isScrollable: Bool) -> some View {
        modifier(ScrollableModifier(isScrollable: isScrollable))
    }
}

private struct ScrollableModifier: ViewModifier {
    let isScrollable: Bool
    
    func body(content: Content) -> some View {
        if isScrollable {
            ScrollView(showsIndicators: false) {
                ViewExpander()
                content
            }
        } else {
            content
        }
    }
}
