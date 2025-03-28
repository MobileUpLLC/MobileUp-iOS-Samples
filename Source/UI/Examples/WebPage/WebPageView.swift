import SwiftUI
import WebKit

struct WebPageView: View {
    @ObservedObject var viewModel: WebPageViewModel
    
    var body: some View {
        VStack(spacing: .zero) {
            if let url = viewModel.url {
                CustomWebView(
                    url: url,
                    redirectUrls: viewModel.redirectUrls,
                    redirectAction: viewModel.redirectAction,
                    errorAction: viewModel.errorAction
                )
                .background(.white)
            }
        }
    }
}

private struct CustomWebView: UIViewRepresentable {
    let url: URL
    let redirectUrls: [URL]
    let redirectAction: Closure.Generic<URL>?
    let errorAction: Closure.Generic<Error>?
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.processPool = WKProcessPool()
        configuration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = false
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(customWebView: self)
    }
}

// Нужен в качестве делегата WKNavigationDelegate для обработки ошибок и перехвата редирект ссылок
private class Coordinator: NSObject {
    private var customWebView: CustomWebView
    
    init(customWebView: CustomWebView) {
        self.customWebView = customWebView
    }
}

extension Coordinator: WKNavigationDelegate {
    // swiftlint:disable contains_over_first_not_nil
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        guard let nextUrl = navigationAction.request.url else {
            return decisionHandler(.cancel)
        }
        
        if nextUrl != customWebView.url,
           customWebView.redirectUrls.first(where: { nextUrl.absoluteString.contains($0.absoluteString) }) != nil {
            customWebView.redirectAction?(nextUrl)
            decisionHandler(.cancel)
            return
        } else if navigationAction.navigationType == .linkActivated {
            if UIApplication.shared.canOpenURL(nextUrl) {
                UIApplication.shared.open(nextUrl)
                decisionHandler(.cancel)
                return
            }
        }
        return decisionHandler(.allow)
    }
    // swiftlint:enable contains_over_first_not_nil
    // swiftlint:disable implicitly_unwrapped_optional
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        customWebView.errorAction?(error)
    }
    // swiftlint:enable implicitly_unwrapped_optional
}

struct WebPageView_Previews: PreviewProvider {
    static let coordinator = WebPageCoordinator()
    static let viewModel = WebPageViewModel(
        coordinator: coordinator,
        pageModel: .init(
            url: URL(string: "https://mobileup.ru/"),
            navigationTitle: "MobileUp page",
            redirectUrls: [],
            redirectAction: nil,
            errorAction: nil
        )
    )
    
    static var previews: some View {
        WebPageView(viewModel: viewModel)
    }
}
