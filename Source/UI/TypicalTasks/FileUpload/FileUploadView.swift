import SwiftUI

struct FileUploadView: View {
    @ObservedObject var viewModel: FileUploadViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Button(R.string.fileUpload.selectDocumentWithDocumentPickerButtonTitle()) {
                viewModel.isDocumentPickerPresented = true
            }
            .buttonStyle(.borderedProminent)
            
            Button(R.string.fileUpload.selectMediaWithPHPickerButtonTitle()) {
                viewModel.isMediaPickerPresented = true
            }
            .buttonStyle(.borderedProminent)
            
            Button(R.string.fileUpload.selectDocumentWithDocumentBrowserButtonTitle()) {
                viewModel.isDocumentBrowserPresnted = true
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: $viewModel.isDocumentPickerPresented) {
            DocumentPicker(onSelect: viewModel.handleDocumentSelection(urls:))
        }
        .sheet(isPresented: $viewModel.isMediaPickerPresented) {
            MediaPicker(onSelect: viewModel.handleMediaSelection(results:))
        }
        .sheet(isPresented: $viewModel.isDocumentBrowserPresnted) {
            DocumentBrowser(onSelect: viewModel.handleDocumentBrowserSelection(url:))
        }
        .background(.white)
    }
}

#Preview {
    FileUploadView(
        viewModel: FileUploadViewModel(coordinator: FileUploadCoordinator(), storageService: DataStorageService<Data>())
    )
}
