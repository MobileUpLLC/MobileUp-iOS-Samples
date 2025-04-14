import SwiftUI

struct DataTransferExampleView: View {
    @ObservedObject var viewModel: DataTransferExampleViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text(R.string.navigation.dataTransferTitle())
                .font(UIFont.Heading.primary.asFont)
                .foregroundStyle(.black)
                .padding(.vertical, 20)
                .padding(.horizontal, 28)
            TextField("Type something", text: $viewModel.textToSend)
                .textFieldStyle(.roundedBorder)
                .padding()
            Group {
                Button(R.string.common.okButtonTitle()) {
                    viewModel.onSubmitTextButtonTapped()
                }
                Button(R.string.navigation.navigationPushControllerButton()) {
                    viewModel.onPushControllerButtonTapped()
                }
                Button(R.string.navigation.navigationPopToNavigationControllerButton()) {
                    viewModel.onPopToNavigationControllerButtonTapped()
                }
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            Spacer()
        }
        .background(.white)
    }
}

#Preview {
    DataTransferExampleView(
        viewModel: DataTransferExampleViewModel(
            coordinator: DataTransferExampleCoordinator(),
            navigationRepository: NavigationRepository(),
            onTextSubmit: { _ in }
        )
    )
}
