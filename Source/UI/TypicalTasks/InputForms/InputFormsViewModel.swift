import Foundation

final class InputFormsViewModel: ObservableObject {
    @Published var isCheckboxSelected: Bool = false
    
    private let coordinator: InputFormsCoordinator
    
    init(coordinator: InputFormsCoordinator) {
        self.coordinator = coordinator
    }
    
    func handleCheckboxSelection() {
        print(isCheckboxSelected ? "Did select checkbox" : "Did deselect checkbox")
    }
}
