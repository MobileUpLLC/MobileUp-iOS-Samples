import Foundation

final class TransparentPresentationExampleViewModel: ObservableObject {
    private let coordinator: TransparentPresentationExampleCoordinator
    
    init(coordinator: TransparentPresentationExampleCoordinator) {
        self.coordinator = coordinator
    }
    
    func onCloseButtonTapped() {
        coordinator.dismiss()
    }
}
