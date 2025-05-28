import SwiftUI

struct ZoomView<Content: View>: UIViewRepresentable {
    private var content: Content
    private let maximumZoomScale: CGFloat
    
    init(maximumZoomScale: CGFloat = 5, @ViewBuilder content: () -> Content) {
        self.maximumZoomScale = maximumZoomScale
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = maximumZoomScale
        scrollView.minimumZoomScale = 1
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        let controller = UIHostingController(rootView: content)
        controller.view.backgroundColor = .clear
        context.coordinator.setupHostingController(with: controller)
        
        if let hostedView = context.coordinator.getViewForZooming() {
            hostedView.translatesAutoresizingMaskIntoConstraints = true
            hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            hostedView.frame = scrollView.bounds
            scrollView.addSubview(hostedView)
        }
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        private var hostingController: UIHostingController<Content>?
        
        func setupHostingController(with controller: UIHostingController<Content>) {
            hostingController = controller
        }
        
        func getViewForZooming() -> UIView? {
            hostingController?.view
        }
    }
}
