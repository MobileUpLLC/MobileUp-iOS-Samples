import Foundation

final class ToastExampleViewModel: ObservableObject {
    private let coordinator: ToastExampleCoordinator
    
    init(coordinator: ToastExampleCoordinator) {
        self.coordinator = coordinator
    }

    func handleShowGlobalToastButton() {
        coordinator.showGlobalToast()
    }

    func handleShowLocalToastButton() {
        coordinator.showLocalToast()
    }
}
