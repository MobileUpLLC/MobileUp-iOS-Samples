import Foundation

final class PresentationExampleViewModel: ObservableObject {
    private let coordinator: PresentationExampleCoordinator
    
    init(coordinator: PresentationExampleCoordinator) {
        self.coordinator = coordinator
    }
    
    func handleTapOnShowFullScreenControllerButton() {
        coordinator.showFullScreenController(isTransparent: false)
    }
    
    func handleTapOnShowTransparentFullScreenControllerButton() {
        coordinator.showFullScreenController(isTransparent: true)
    }
}
