import SwiftUI

struct ScrollWithToolBarView<Content: View, ToolBar: View>: View {
    let content: () -> Content
    let bottomToolBar: (Binding<Bool>) -> ToolBar
    
    @State private var isKeyboardShown = false
    @State private var isContentOverToolBar = false
    @State private var contentHeight: CGFloat = 0
    @State private var scrollViewHeight: CGFloat = 0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            content()
                .readSize { size in
                    contentHeight = size.height
                }
                .onTapGesture {
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder),
                        to: nil,
                        from: nil,
                        for: nil
                    )
                }
        }
        .readSize { size in
            scrollViewHeight = size.height
        }
        .safeAreaInset(edge: .bottom) {
            bottomToolBar($isContentOverToolBar)
        }
        .enableContentMargin(height: isKeyboardShown ? 16 : 0)
        .onChange(of: contentHeight) { newHeight in
            isContentOverToolBar = newHeight > scrollViewHeight
        }
        .onChange(of: scrollViewHeight) { newScrollViewHeight in
            isContentOverToolBar = contentHeight > newScrollViewHeight
        }
        .observeKeyboard { keyboardHeight in
            withAnimation {
                isKeyboardShown = keyboardHeight > 0
            }
        }
    }
}

#Preview {
    struct ScrollViewWithToolBarWrapper: View {
        @State private var isContentFit = true
        @State private var isShowDivider = false
        
        var body: some View {
            ScrollWithToolBarView {
                SkeletonContentView()
            } bottomToolBar: { isContentFill in
                Button("Button") {}
            }
        }
    }
    
    return ScrollViewWithToolBarWrapper()
}
