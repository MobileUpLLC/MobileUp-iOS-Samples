import Foundation

final class EntranceViewModel: ViewModel {
    private let coordinator: EntranceCoordinator
    
    init(coordinator: EntranceCoordinator) {
        self.coordinator = coordinator
    }
    
    func handleTapOnAuthorizationButton() {
        coordinator.showAuthorizationModule()
    }
    
    func handleTapOnRegistrationButton() {
        coordinator.showRegistrationModule()
    }
    
    func handleTapOnTabBarButton() {
        coordinator.showTabbarModule()
    }
}
