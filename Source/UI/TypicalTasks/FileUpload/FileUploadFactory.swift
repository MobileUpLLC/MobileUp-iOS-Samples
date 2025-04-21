enum FileUploadFactory {
    static func createFileUploadController() -> FileUploadController {
        let coordinator = FileUploadCoordinator()
        let viewModel = FileUploadViewModel(coordinator: coordinator)
        let controller = FileUploadController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
