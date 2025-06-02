import Foundation

final class OnboardingExampleViewModel: ViewModel {
    private let coordinator: OnboardingExampleCoordinator
    
    init(coordinator: OnboardingExampleCoordinator) {
        self.coordinator = coordinator
    }
    
    func showCommonOnboardingScreen() {
        coordinator.showCommonOnboardingScreen(onboardingType: .testOnboarding)
    }
    
    func showOnboardingWithElementFocus() {
        coordinator.showOnboardingWithElementFocus()
    }
}
