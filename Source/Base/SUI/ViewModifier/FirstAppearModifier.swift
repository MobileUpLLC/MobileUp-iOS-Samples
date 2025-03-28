import SwiftUI

// вызовет action только при первом появлении view
extension View {
    func onFirstAppear(_ action: @escaping Closure.Void) -> some View {
        modifier(FirstAppearModifier(action: action))
    }
}

private struct FirstAppearModifier: ViewModifier {
    let action: Closure.Void
    
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        content.onAppear {
            guard hasAppeared == false else {
                return
            }
            
            hasAppeared = true
            action()
        }
    }
}
