import Foundation

final class TransparentPresentationViewModel: ObservableObject {
    private let coordinator: TransparentPresentationCoordinator
    
    init(coordinator: TransparentPresentationCoordinator) {
        self.coordinator = coordinator
    }
    
    func onCloseButtonTapped() {
        coordinator.dismiss()
    }
}
