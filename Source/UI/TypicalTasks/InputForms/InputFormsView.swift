import SwiftUI
import FormView

struct InputFormsView: View {
    @ObservedObject var viewModel: InputFormsViewModel
    
    @State private var isAllFieldValid = false
    
    var body: some View {
        FormView(
            validate: [.manual, .onFieldValueChanged, .onFieldFocus],
            hideError: .onValueChanged,
            isAllFieldValid: $isAllFieldValid
        ) { proxy in
            HStack {
                Checkbox(
                    isSelected: $viewModel.isCheckboxSelected,
                    label: "Test checkbox",
                    onTapAction: viewModel.handleCheckboxAction
                )
                Spacer()
            }
            ToggleView(
                isSelected: $viewModel.isToggleSelected,
                label: "Test toggle",
                onTapAction: viewModel.handleToggleAction
            )
            DropdownMenuView(
                isFocused: $viewModel.isDropDownMenuFocused,
                selectedItem: $viewModel.selectedDropDownMenuItem,
                title: "Test dropdown menu",
                items: viewModel.dropDownMenuItems,
                onSelection: viewModel.handleDropDownMenuSelectAction(item:)
            )
            FormField(
                value: $viewModel.name,
                rules: viewModel.nameValidationRules,
                isRequired: true
            ) { failedRules in
                UniversalFieldView(
                    config: TextFieldConfiguration(
                        title: "Name",
                        value: $viewModel.name,
                        mode: .singleline(isSecure: false),
                        failedRules: failedRules
                    )
                )
            }
            .disabled(viewModel.isLoading)
            FormField(
                value: $viewModel.age,
                rules: viewModel.ageValidationRules,
                isRequired: false
            ) { failedRules in
                UniversalFieldView(
                    config: TextFieldConfiguration(
                        title: "Age",
                        value: $viewModel.age,
                        mode: .singleline(isSecure: false),
                        failedRules: failedRules
                    )
                )
            }
            .disabled(viewModel.isLoading)
            FormField(
                value: $viewModel.pass,
                rules: viewModel.passValidationRules,
                isRequired: true
            ) { failedRules in
                UniversalFieldView(
                    config: TextFieldConfiguration(
                        title: "Password",
                        value: $viewModel.pass,
                        mode: .singleline(isSecure: true),
                        failedRules: failedRules
                    )
                )
            }
            .disabled(viewModel.isLoading)
            FormField(
                value: $viewModel.confirmPass,
                rules: viewModel.confirmPassValidationRules,
                isRequired: true
            ) { failedRules in
                UniversalFieldView(
                    config: TextFieldConfiguration(
                        title: "Confirm Password",
                        value: $viewModel.confirmPass,
                        mode: .singleline(isSecure: true),
                        failedRules: failedRules
                    )
                )
            }
            .disabled(viewModel.isLoading)
            FormField(
                value: $viewModel.testMultiline,
                rules: viewModel.testMultilineValidationRules,
                isRequired: true
            ) { failedRules in
                UniversalFieldView(
                    config: TextFieldConfiguration(
                        title: "Test Universal Multiline",
                        value: $viewModel.testMultiline,
                        mode: .multiline(lineLimit: 8, isDynamic: false),
                        failedRules: failedRules
                    )
                )
            }
            .disabled(viewModel.isLoading)
            FormField(
                value: $viewModel.testDynamicMultiline,
                rules: viewModel.testDynamicMultilineValidationRules,
                isRequired: true
            ) { failedRules in
                UniversalFieldView(
                    config: TextFieldConfiguration(
                        title: "Test Universal Dynamic Multiline",
                        value: $viewModel.testDynamicMultiline,
                        mode: .multiline(lineLimit: 8, isDynamic: true),
                        failedRules: failedRules
                    )
                )
            }
            .disabled(viewModel.isLoading)
            if viewModel.isLoading {
                ProgressView()
            }
            Button("Validate") {
                Task {
                    print("Form is valid: \(await proxy.validate())")
                }
            }
            .disabled(isAllFieldValid == false || viewModel.isLoading)
        }
        .textFieldStyle(.roundedBorder)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .wrappedInScrollView(isScrollable: true)
    }
}

#Preview {
    InputFormsView(viewModel: InputFormsViewModel(coordinator: InputFormsCoordinator()))
}
