import SwiftUI

struct DataTransferView: View {
    @ObservedObject var viewModel: DataTransferViewModel
    
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
            .padding()
            Spacer()
        }
        .background(.white)
    }
}

#Preview {
    DataTransferView(
        viewModel: DataTransferViewModel(
            coordinator: DataTransferCoordinator(),
            navigationRepository: NavigationRepository(),
            onTextSubmit: { _ in }
        )
    )
}
