import Foundation

final class EntranceViewModel: ViewModel {
    private let coordinator: EntranceCoordinator
    
    init(coordinator: EntranceCoordinator) {
        self.coordinator = coordinator
    }
    
    // TODO: UPUP-1022 Реализовать авторизацию и регистрацию
    func onAuthorizationButtonTapped() {}
    
    func onRegistrationButtonTapped() {
        coordinator.openTypicalTasks()
    }
}
