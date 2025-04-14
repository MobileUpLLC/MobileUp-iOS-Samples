import Foundation

final class PresentationExampleViewModel: ObservableObject {
    private let coordinator: PresentationExampleCoordinator
    
    init(coordinator: PresentationExampleCoordinator) {
        self.coordinator = coordinator
    }
    
    func onShowFullScreenControllerButtonTapped() {
        coordinator.showFullScreenController(isTransparent: false)
    }
    
    func onShowTransparentFullScreenControllerButtonTapped() {
        coordinator.showFullScreenController(isTransparent: true)
    }
}
