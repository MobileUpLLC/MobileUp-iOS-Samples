import Foundation

final class InputFormsViewModel: ObservableObject {
    private let coordinator: InputFormsCoordinator
    
    init(coordinator: InputFormsCoordinator) {
        self.coordinator = coordinator
    }
}
