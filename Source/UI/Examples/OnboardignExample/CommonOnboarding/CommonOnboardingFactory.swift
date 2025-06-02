import UIKit

enum CommonOnboardingFactory {
    static func createCommonOnboardingController(
        with onboardingType: CommonOnboardingType
    ) -> CommonOnboardingController {
        let coordinator = CommonOnboardingCoordinator()
        let viewModel = CommonOnboardingViewModel(coordinator: coordinator, onboardingType: onboardingType)
        let controller = CommonOnboardingController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
