import SwiftUI

struct InputFormsView: View {
    @ObservedObject var viewModel: InputFormsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer()
            Text("InputForms module created!")
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
            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(.white)
    }
}

#Preview {
    InputFormsView(
        viewModel: InputFormsViewModel(
            coordinator: InputFormsCoordinator()
        )
    )
}
