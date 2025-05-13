import Foundation

final class InputFormsViewModel: ObservableObject {
    @Published var isCheckboxSelected = false
    @Published var isToggleSelected = false
    
    private let coordinator: InputFormsCoordinator
    
    init(coordinator: InputFormsCoordinator) {
        self.coordinator = coordinator
    }
    
    func handleCheckboxAction() {
        print(isCheckboxSelected ? "Did select checkbox" : "Did deselect checkbox")
    }
    
    func handleToggleAction() {
        print(isToggleSelected ? "Did activate toggle" : "Did deactivate toggle")
    }
}
