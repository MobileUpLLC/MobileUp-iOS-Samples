import Foundation

final class EntranceViewModel: ViewModel {
    private let coordinator: EntranceCoordinator
    
    init(coordinator: EntranceCoordinator) {
        self.coordinator = coordinator
    }
    
    func onAuthorizationButtonTapped() {
        coordinator.showAuthorizationModule()
    }
    
    func onRegistrationButtonTapped() {
        coordinator.showRegistrationModule()
    }
}
