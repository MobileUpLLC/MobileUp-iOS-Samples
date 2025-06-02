import UIKit

enum OnboardingExampleFactory {
    static func createOnboardingExampleController() -> OnboardingExampleController {
        let coordinator = OnboardingExampleCoordinator()
        let viewModel = OnboardingExampleViewModel(coordinator: coordinator)
        let controller = OnboardingExampleController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
