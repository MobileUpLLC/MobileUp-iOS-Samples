import Foundation

final class OnboardingWithElementFocusViewModel: ViewModel {
    private let coordinator: OnboardingWithElementFocusCoordinator
    
    init(coordinator: OnboardingWithElementFocusCoordinator) {
        self.coordinator = coordinator
    }
}
