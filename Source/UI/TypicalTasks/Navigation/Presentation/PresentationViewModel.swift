import Foundation

final class PresentationViewModel: ObservableObject {
    private let coordinator: PresentationCoordinator
    
    init(coordinator: PresentationCoordinator) {
        self.coordinator = coordinator
    }
    
    func onShowFullScreenControllerButtonTapped() {
        coordinator.showFullScreenController()
    }
    
    func onShowTransparentFullScreenControllerButtonTapped() {
        coordinator.showTransparentFullScreenController()
    }
}
