import SwiftUI

struct FileUploadView: View {
    @ObservedObject var viewModel: FileUploadViewModel

    var body: some View {
        Text("FileUpload module created!")
    }
}

#Preview {
    FileUploadView(
        viewModel: FileUploadViewModel(coordinator: FileUploadCoordinator())
    )
}
