import UIKit

enum RegistrationFactory {
    static func createRegistrationController() -> RegistrationController {
        let coordinator = RegistrationCoordinator()
        let authRepository = AuthRepository()
        let viewModel = RegistrationViewModel(
            coordinator: coordinator,
            authRepository: authRepository
        )
        
        let controller = RegistrationController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
