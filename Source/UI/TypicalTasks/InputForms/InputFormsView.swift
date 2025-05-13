import SwiftUI

struct InputFormsView: View {
    @ObservedObject var viewModel: InputFormsViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text("InputForms module created!")
            Checkbox(
                isSelected: $viewModel.isCheckboxSelected,
                label: "Test checkbox",
                onTapAction: viewModel.handleCheckboxSelection
            )
            Spacer()
        }
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
