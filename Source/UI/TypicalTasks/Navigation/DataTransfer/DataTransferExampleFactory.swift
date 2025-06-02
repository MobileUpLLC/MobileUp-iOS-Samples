enum DataTransferExampleFactory {
    static func createDataTransferExampleController(onTextSubmit: Closure.String?) -> DataTransferExampleController {
        let coordinator = DataTransferExampleCoordinator()
        let navigationRepository = NavigationRepository()
        let viewModel = DataTransferExampleViewModel(
            coordinator: coordinator,
            navigationRepository: navigationRepository,
            onTextSubmit: onTextSubmit
        )
        let controller = DataTransferExampleController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
