import Foundation
import FormView

final class InputFormsViewModel: ObservableObject {
    @Published var isCheckboxSelected = false
    @Published var isToggleSelected = false
    @Published var isDropDownMenuFocused = false
    @Published var selectedDropDownMenuItem: String = .empty
    @Published var name: String = ""
    @Published var age: String = ""
    @Published var pass: String = ""
    @Published var confirmPass: String = ""
    @Published var testSingleline: String = ""
    @Published var testMultiline: String = ""
    @Published var testDynamicMultiline: String = ""
    @Published var isLoading = false
    
    var nameValidationRules: [ValidationRule] = []
    var ageValidationRules: [ValidationRule] = []
    var passValidationRules: [ValidationRule] = []
    var confirmPassValidationRules: [ValidationRule] = []
    var testSinglelineValidationRules: [ValidationRule] = []
    var testMultilineValidationRules: [ValidationRule] = []
    var testDynamicMultilineValidationRules: [ValidationRule] = []
    
    let dropDownMenuItems: [String] = ["item 1", "item 2", "item 3"]
    
    private let coordinator: InputFormsCoordinator
    
    init(coordinator: InputFormsCoordinator) {
        self.coordinator = coordinator
        
        selectedDropDownMenuItem = dropDownMenuItems.first ?? .empty
        setupValidationRules()
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
    
    private func setupValidationRules() {
        nameValidationRules = [
            ValidationRule.notEmpty(conditions: [.manual, .onFieldValueChanged, .onFieldFocus], message: "Name empty"),
            ValidationRule.noSpecialCharacters(
                conditions: [.manual, .onFieldValueChanged, .onFieldFocus],
                message: "No spec chars"
            ),
            ValidationRule.myRule,
            ValidationRule.external { [weak self] in
                guard let self else {
                    return (true, "")
                }
                
                return await self.availabilityCheckAsync($0)
            }
        ]
        
        ageValidationRules = [
            ValidationRule.digitsOnly(conditions: [.manual, .onFieldValueChanged], message: "Digits only"),
            ValidationRule.maxLength(conditions: [.manual, .onFieldValueChanged], count: 2, message: "Max length 2")
        ]
        
        passValidationRules = [
            ValidationRule.atLeastOneDigit(conditions: [.manual, .onFieldValueChanged], message: "One digit"),
            ValidationRule.atLeastOneLetter(conditions: [.manual, .onFieldValueChanged], message: "One letter"),
            ValidationRule.notEmpty(conditions: [.manual, .onFieldValueChanged], message: "Pass not empty")
        ]
        
        confirmPassValidationRules = [
            ValidationRule.notEmpty(conditions: [.manual, .onFieldValueChanged], message: "Confirm pass not empty"),
            ValidationRule.custom(conditions: [.manual, .onFieldValueChanged]) { [weak self] in
                return ($0 == self?.pass, "Not equal to pass")
            }
        ]
        
        testSinglelineValidationRules = [
            ValidationRule.notEmpty(conditions: [.manual, .onFieldValueChanged], message: "Test universal not empty")
        ]
        
        testMultilineValidationRules = [
            ValidationRule.notEmpty(conditions: [.manual, .onFieldValueChanged], message: "Test universal not empty")
        ]
        
        testDynamicMultilineValidationRules = [
            ValidationRule.notEmpty(conditions: [.manual, .onFieldValueChanged], message: "Test universal not empty")
        ]
    }
    
    @MainActor
    private func availabilityCheckAsync(_ value: String) async -> (Bool, String) {
        print(#function)
        
        isLoading = true
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let isAvailable = Bool.random()
        
        isLoading = false
        
        return (isAvailable, "Not available")
    }
}
