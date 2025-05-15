import SwiftUI
import FormView

struct InputFormsView: View {
    @ObservedObject var viewModel: InputFormsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Checkbox(
                isSelected: $viewModel.isCheckboxSelected,
                label: "Test checkbox",
                onTapAction: viewModel.handleCheckboxAction
            )
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
            FormView(
                validate: [.manual, .onFieldValueChanged, .onFieldFocus],
                hideError: .onValueChanged
            ) { _ in
                FormField(
                    value: $viewModel.name,
                    rules: viewModel.nameValidationRules
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
                    rules: viewModel.ageValidationRules
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
                    rules: viewModel.passValidationRules
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
                    rules: viewModel.confirmPassValidationRules
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
                    rules: viewModel.testMultilineValidationRules
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
                    rules: viewModel.testDynamicMultilineValidationRules
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
            }
            .textFieldStyle(.roundedBorder)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .wrappedInScrollView(isScrollable: true)
    }
}

#Preview {
    InputFormsView(viewModel: InputFormsViewModel(coordinator: InputFormsCoordinator()))
}
