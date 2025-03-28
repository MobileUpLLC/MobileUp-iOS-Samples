import SwiftUI

// добавляет разделитель внизу view. В основном применяется к списку,
// когда разделитель должен быть у всех элементов, кроме последнего.
extension View {
    func divideIfNeeded(color: Color, count: Int, currentIndex: Int) -> some View {
        modifier(DivideIfNeededModifier(dataCount: count, currentIndex: currentIndex, color: color))
    }
}

private struct DivideIfNeededModifier: ViewModifier {
    let dataCount: Int
    let currentIndex: Int
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if currentIndex != dataCount - 1 {
                    DividerView(color: color)
                }
            }
    }
}

private struct DividerView: View {
    let color: Color
    
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .frame(height: 1)
    }
}
