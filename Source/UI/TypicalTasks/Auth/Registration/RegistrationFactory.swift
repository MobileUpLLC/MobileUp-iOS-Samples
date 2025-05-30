import UIKit

enum RegistrationFactory {
    static func createRegistrationController(networkService: NetworkService) -> RegistrationController {
        let coordinator = RegistrationCoordinator(networkService: networkService)
        let authRepository = AuthRepository(networkService: networkService)
        let viewModel = RegistrationViewModel(
            coordinator: coordinator,
            authRepository: authRepository
        )
        
        let controller = RegistrationController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
