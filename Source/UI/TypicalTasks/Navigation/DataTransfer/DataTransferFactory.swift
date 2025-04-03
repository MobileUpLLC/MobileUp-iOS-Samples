enum DataTransferFactory {
    static func createDataTransferController(
        onTextSubmit: @escaping (String) -> Void
    ) -> DataTransferController {
        let coordinator = DataTransferCoordinator()
        let navigationRepository = NavigationRepository()
        let viewModel = DataTransferViewModel(
            coordinator: coordinator,
            navigationRepository: navigationRepository,
            onTextSubmit: onTextSubmit
        )
        let controller = DataTransferController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
