enum StorageFactory {
    static func createStorageController() -> StorageController {
        let viewModel = StorageViewModel(storageRepository: .shared)
        let controller = StorageController(viewModel: viewModel)
        
        return controller
    }
}
