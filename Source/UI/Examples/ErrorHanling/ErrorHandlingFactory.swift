enum ErrorHandlingFactory {
    static func createErrorHandlingController() -> ErrorHandlingController {
        let viewModel = ErrorHandlingViewModel()
        let controller = ErrorHandlingController(viewModel: viewModel)
        
        return controller
    }
}
