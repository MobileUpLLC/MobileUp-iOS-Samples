import Foundation

final class EntranceViewModel: ViewModel {
    private let coordinator: EntranceCoordinator
    
    init(coordinator: EntranceCoordinator) {
        self.coordinator = coordinator
    }
    
    func handleAuthorizationButtonTapped() {
        coordinator.showAuthorizationModule()
    }
    
    func handleRegistrationButtonTapped() {
        coordinator.showRegistrationModule()
    }
    
    func handleGoToUnauthorizedZoneButtonTapped() {
        Task { [weak self] in
            await self?.coordinator.showTabbarModule()
        }
    }
}
