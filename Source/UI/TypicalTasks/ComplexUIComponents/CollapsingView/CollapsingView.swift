import SwiftUI

struct CollapsingView: View {
    @State private var isCollapsed = false
    
    private let onlyFromTop: Bool
    
    var body: some View {
        Group {
            if onlyFromTop {
                fromTopScrollCollapsingView
            } else {
                onAnyScrollCollapsingView
            }
        }
        .animation(.easeInOut, value: isCollapsed)
    }
    
    var onAnyScrollCollapsingView: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundStyle(.orange)
                .padding()
                .frame(height: isCollapsed ? 0 : 400)
            CollapsingUIScrollViewWrapper(
                content: content,
                onDidScroll: { y in isCollapsed = y < 0 },
                onScrollFromTop: nil
            )
        }
    }
    
    var fromTopScrollCollapsingView: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundStyle(.orange)
                .padding()
                .frame(height: isCollapsed ? 0 : 400)
            CollapsingUIScrollViewWrapper(
                content: content,
                onDidScroll: { scrollOffsetY in
                    if isCollapsed {
                        return
                    }
                    
                    isCollapsed = scrollOffsetY < 0
                },
                onScrollFromTop: { contentOffsetY in
                    if contentOffsetY <= 0 {
                        isCollapsed = false
                    }
                }
            )
        }
    }
    
    var content: some View {
        VStack(spacing: 0) {
            ForEach(0..<30) { _ in
                Rectangle()
                    .frame(height: 50)
                    .padding()
            }
        }
    }
    
    init(onlyFromTop: Bool) {
        self.onlyFromTop = onlyFromTop
    }
}

#Preview {
    CollapsingView(onlyFromTop: true)
}
