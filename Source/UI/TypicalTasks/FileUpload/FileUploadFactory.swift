import Foundation

enum FileUploadFactory {
    static func createFileUploadController() -> FileUploadController {
        let coordinator = FileUploadCoordinator()
        let storageService = DataStorageService<Data>()
        let viewModel = FileUploadViewModel(coordinator: coordinator, storageService: storageService)
        let controller = FileUploadController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
