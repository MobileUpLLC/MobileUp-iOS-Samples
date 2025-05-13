import Foundation

final class InputFormsViewModel: ObservableObject {
    @Published var isCheckboxSelected = false
    @Published var isToggleSelected = false
    @Published var isDropDownMenuFocused = false
    @Published var selectedDropDownMenuItem: String = .empty
    
    let dropDownMenuItems: [String] = ["item 1", "item 2", "item 3"]
    
    private let coordinator: InputFormsCoordinator
    
    init(coordinator: InputFormsCoordinator) {
        self.coordinator = coordinator
        
        selectedDropDownMenuItem = dropDownMenuItems.first ?? .empty
    }
    
    func handleCheckboxAction() {
        print(isCheckboxSelected ? "Did select checkbox" : "Did deselect checkbox")
    }
    
    func handleToggleAction() {
        print(isToggleSelected ? "Did activate toggle" : "Did deactivate toggle")
    }
    
    func handleDropDownMenuSelectAction(item: String) {
        print("Did select \(item)")
    }
}
