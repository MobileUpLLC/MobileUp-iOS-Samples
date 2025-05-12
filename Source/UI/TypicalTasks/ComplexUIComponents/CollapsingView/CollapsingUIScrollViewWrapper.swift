import SwiftUI
import SnapKit

struct CollapsingUIScrollViewWrapper<Content: View>: UIViewRepresentable {
    let content: Content
    let onDidScroll: Closure.Double
    let onScrollFromTop: Closure.Double?
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        
        let hostingController = UIHostingController(rootView: content)
        context.coordinator.hostingController = hostingController
        hostingController.view.backgroundColor = .white
        
        scrollView.addSubview(hostingController.view)
        
        hostingController.view.snp.makeConstraints { make in
            make.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            make.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onDidScroll: onDidScroll, onScrollFromTop: onScrollFromTop)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate, UIGestureRecognizerDelegate {
        var hostingController: UIHostingController<Content>?
        let onDidScroll: Closure.Double
        let onScrollFromTop: Closure.Double?
        
        init(onDidScroll: @escaping Closure.Double, onScrollFromTop: Closure.Double?) {
            self.onDidScroll = onDidScroll
            self.onScrollFromTop = onScrollFromTop
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let point = scrollView.panGestureRecognizer.translation(in: scrollView)
            onScrollFromTop?(scrollView.contentOffset.y)
            onDidScroll(point.y)
        }
    }
}
