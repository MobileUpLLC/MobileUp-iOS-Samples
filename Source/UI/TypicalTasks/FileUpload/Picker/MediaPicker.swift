import SwiftUI
import PhotosUI

struct MediaPicker: UIViewControllerRepresentable {
    let onSelect: Closure.Generic<[PHPickerResult]>
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onSelect: onSelect)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let onSelect: Closure.Generic<[PHPickerResult]>
        
        init(onSelect: @escaping Closure.Generic<[PHPickerResult]>) {
            self.onSelect = onSelect
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            onSelect(results)
        }
    }
}
