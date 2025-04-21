import Foundation

final class FileUploadViewModel: ObservableObject {
    private let coordinator: FileUploadCoordinator
    
    init(coordinator: FileUploadCoordinator) {
        self.coordinator = coordinator
    }
}
