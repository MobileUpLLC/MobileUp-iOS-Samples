import SwiftUI

// считывает offset контента, например у scroll view
extension View {
    func readOffset(tag: Namespace.ID, onChange: @escaping Closure.Generic<CGFloat>) -> some View {
        background {
            GeometryReader {
                Color.clear.preference(
                    key: OffsetKey.self,
                    value: -$0.frame(in: .named(tag)).origin.y)
            }
        }
        .onPreferenceChange(OffsetKey.self, perform: onChange)
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
