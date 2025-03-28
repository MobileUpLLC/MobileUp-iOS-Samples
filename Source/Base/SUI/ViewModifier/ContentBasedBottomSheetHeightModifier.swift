import SwiftUI

// задаст для bottomSheet высоту равную высоте view
extension View {
    func сontentBasedBottomSheetHeight() -> some View {
        modifier(ContentBasedBottomSheetHeightModifier())
    }
}

private struct ContentBasedBottomSheetHeightModifier: ViewModifier {
    @State private var contentHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .fixedSize(horizontal: false, vertical: true)
            .readSize { contentHeight = $0.height }
            .presentationDetents([.height(contentHeight)])
    }
}
