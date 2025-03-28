import SwiftUI

struct ToastExampleView: View {
    @ObservedObject var viewModel: ToastExampleViewModel

    var body: some View {
        Button("Show local toast") {
            viewModel.handleShowLocalToastButton()
        }

        Button("Show global toast") {
            viewModel.handleShowGlobalToastButton()
        }
    }
}

#Preview {
    ToastExampleView(
        viewModel: ToastExampleViewModel(
            coordinator: ToastExampleCoordinator()
        )
    )
}
