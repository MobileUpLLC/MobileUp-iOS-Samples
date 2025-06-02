import Foundation

final class ToastExampleViewModel: ObservableObject {
    private let coordinator: ToastExampleCoordinator
    
    init(coordinator: ToastExampleCoordinator) {
        self.coordinator = coordinator
    }

    func handleTapOnShowGlobalToastButton() {
        coordinator.showGlobalToast()
    }

    func handleTapOnShowLocalToastButton() {
        coordinator.showLocalToast()
    }
}
