import SwiftUI
import Combine

extension View {
    func onDebouncedTextChange(
        text: Published<String>.Publisher,
        delay: RunLoop.SchedulerTimeType.Stride = 0.5,
        action: @escaping Closure.Void
    ) -> some View {
        modifier(TextDebounceModifier(text: text, delay: delay, onDebouncedTextChange: action))
    }
}

private struct TextDebounceModifier: ViewModifier {
    let text: Published<String>.Publisher
    let delay: RunLoop.SchedulerTimeType.Stride
    let onDebouncedTextChange: Closure.Void
    
    @SwiftUI.State private var latestText: String = .empty
        
    func body(content: Content) -> some View {
        content
            .onReceive(text.debounce(for: delay, scheduler: RunLoop.main)) { debouncedText in
                if debouncedText != latestText {
                    onDebouncedTextChange()
                    latestText = debouncedText
                }
            }
    }
}
