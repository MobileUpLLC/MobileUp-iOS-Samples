import SwiftUI
import UniformTypeIdentifiers

struct DocumentBrowser: UIViewControllerRepresentable {
    let onSelect: Closure.Generic<URL>
    
    func makeUIViewController(context: Context) -> UIDocumentBrowserViewController {
        let browser = UIDocumentBrowserViewController()
        browser.delegate = context.coordinator
        return browser
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentBrowserViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onSelect: onSelect)
    }
    
    class Coordinator: NSObject, UIDocumentBrowserViewControllerDelegate {
        let onSelect: Closure.Generic<URL>
        
        init(onSelect: @escaping Closure.Generic<URL>) {
            self.onSelect = onSelect
        }
        
        func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
            controller.dismiss(animated: true)
            
            if let url = documentURLs.first {
                onSelect(url)
            }
        }
        
        func documentBrowser(
            _ controller: UIDocumentBrowserViewController,
            didImportDocumentAt sourceURL: URL,
            to destinationURL: URL
        ) {
            onSelect(destinationURL)
        }
        
        func documentBrowser(
            _ controller: UIDocumentBrowserViewController,
            didRequestDocumentCreationWithHandler importHandler: @escaping (
                URL?,
                UIDocumentBrowserViewController.ImportMode
            ) -> Void
        ) {
            importHandler(nil, .none)
        }
    }
}
