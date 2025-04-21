import UIKit

enum OnboardingWithElementFocusFactory {
    static func createOnboardingWithElementFocusController() -> OnboardingWithElementFocusController {
        let coordinator = OnboardingWithElementFocusCoordinator()
        let viewModel = OnboardingWithElementFocusViewModel(coordinator: coordinator)
        let controller = OnboardingWithElementFocusController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
