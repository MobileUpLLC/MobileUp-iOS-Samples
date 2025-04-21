import SwiftUI

struct DocumentPicker: UIViewControllerRepresentable {
    let onSelect: Closure.Generic<[URL]>
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf, .text])
        documentPicker.delegate = context.coordinator
        documentPicker.allowsMultipleSelection = false
        
        return documentPicker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onSelect: onSelect)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let onSelect: Closure.Generic<[URL]>
        
        init(onSelect: @escaping Closure.Generic<[URL]>) {
            self.onSelect = onSelect
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            onSelect(urls)
        }
    }
}
