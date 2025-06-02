import SwiftUI

struct BottomToolBarButton<Content: View>: View {
    @Binding private var isShowDivider: Bool
    @Binding private var isLoading: Bool
    
    private let title: String
    private let bottomContent: () -> Content
    private let action: Closure.Void
    
    @Environment(\.keyboardHeight) private var keyboardHeight
    @State private var isKeyboardShown = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Button(title) {
                    action()
                }
                
                bottomContent()
            }
            .padding(.top, 16)
            .padding(.bottom, isKeyboardShown || UIApplication.getSafeAreaInsets().bottom.isZero ? 16 : 0)
            .padding(.horizontal, 20)
        }
        .background(.white)
        .animation(.easeInOut, value: isShowDivider)
        .onChange(of: keyboardHeight) { newKeyboardHeight in
            isKeyboardShown = newKeyboardHeight > 0
            isShowDivider = isKeyboardShown
        }
    }
    
    init(
        title: String,
        isShowDivider: Binding<Bool>,
        isLoading: Binding<Bool>,
        bottomContent: @escaping () -> Content = { EmptyView() },
        action: @escaping Closure.Void
    ) {
        self.title = title
        self._isShowDivider = isShowDivider
        self._isLoading = isLoading
        self.bottomContent = bottomContent
        self.action = action
    }
}

#Preview {
    VStack {
        Spacer()
        
        BottomToolBarButton(
            title: "Sign Up",
            isShowDivider: .constant(false),
            isLoading: .constant(false),
            action: {}
        )
        
        BottomToolBarButton(
            title: "Sign Up",
            isShowDivider: .constant(true),
            isLoading: .constant(true),
            action: {}
        )
        .disabled(true)
        
        BottomToolBarButton(
            title: "Sign Up",
            isShowDivider: .constant(true),
            isLoading: .constant(false),
            action: {}
        )
    }
}
