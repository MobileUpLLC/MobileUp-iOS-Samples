import UIKit
import PhotosUI

final class FileUploadViewModel: ObservableObject {
    @Published var isDocumentPickerPresented = false
    @Published var isMediaPickerPresented = false
    @Published var isDocumentBrowserPresnted = false
    
    private let coordinator: FileUploadCoordinator
    private let storageService: DataStorageService<Data>
    
    init(coordinator: FileUploadCoordinator, storageService: DataStorageService<Data>) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    
    func handleDocumentSelection(urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            return
        }
        
        guard selectedFileURL.startAccessingSecurityScopedResource() else {
            print("Failed to access security-scoped resource")
            return
        }
        defer { selectedFileURL.stopAccessingSecurityScopedResource() }
        
        do {
            let fileData = try Data(contentsOf: selectedFileURL)
            try storageService.setObject(fileData, forKey: "selectedFile", expiry: .never)
            print("Document saved to UserDefaults")
        } catch {
            print("Error saving document: \(error)")
        }
    }
    
    func handleMediaSelection(results: [PHPickerResult]) {
        guard let provider = results.first?.itemProvider else {
            return
        }
        
        if provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self else {
                        return
                    }
                    
                    if let image = image as? UIImage, let imageData = image.jpegData(compressionQuality: 0.8) {
                        do {
                            try self.storageService.setObject(imageData, forKey: "selectedFile", expiry: .never)
                            print("Image saved to UserDefaults")
                        } catch {
                            print("Error saving image: \(error)")
                        }
                    } else if let error = error {
                        print("Error loading image: \(error)")
                    }
                }
            }
        }
    }
    
    func handleDocumentBrowserSelection(url: URL) {
        guard url.startAccessingSecurityScopedResource() else {
            print("Failed to access security-scoped resource")
            return
        }
        defer { url.stopAccessingSecurityScopedResource() }
        
        do {
            let fileData = try Data(contentsOf: url)
            try storageService.setObject(fileData, forKey: "selectedFile", expiry: .never)
            print("Document saved to UserDefaults from browser")
        } catch {
            print("Error saving document: \(error)")
        }
    }
}
