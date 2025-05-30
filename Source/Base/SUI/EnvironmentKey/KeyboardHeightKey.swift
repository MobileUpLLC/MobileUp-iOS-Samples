import SwiftUI
import Combine

struct KeyboardHeightKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0
}

extension EnvironmentValues {
    var keyboardHeight: CGFloat {
        get { self[KeyboardHeightKey.self] }
        set { self[KeyboardHeightKey.self] = newValue }
    }
}

extension View {
    func observeKeyboard(onKeyboardHeightChange: @escaping (CGFloat) -> Void) -> some View {
        self.modifier(KeyboardObserver(onKeyboardHeightChange: onKeyboardHeightChange))
    }
}

struct KeyboardObserver: ViewModifier {
    @StateObject private var keyboardObserver = KeyboardObserverModel()
    var onKeyboardHeightChange: (CGFloat) -> Void
    
    func body(content: Content) -> some View {
        content
            .environment(\.keyboardHeight, keyboardObserver.keyboardHeight)
            .onChange(of: keyboardObserver.keyboardHeight) { newHeight in
                onKeyboardHeightChange(newHeight)
            }
    }
}

private final class KeyboardObserverModel: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    
    init() {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { notification -> CGFloat in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
            }
        
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        Publishers.Merge(willShow, willHide)
            .receive(on: RunLoop.main)
            .assign(to: &$keyboardHeight)
        // Эта подписка автоматически отменяется при уничтожении объекта
        // Так как используется @Published,
        // в котором подписки автоматически отменяться при уничтожении объекта
    }
}
