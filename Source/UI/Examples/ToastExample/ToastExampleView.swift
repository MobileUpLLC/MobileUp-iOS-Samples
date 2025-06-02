import SwiftUI

struct ToastExampleView: View {
    @ObservedObject var viewModel: ToastExampleViewModel

    var body: some View {
        Button("Show local toast") {
            viewModel.handleTapOnShowLocalToastButton()
        }

        Button("Show global toast") {
            viewModel.handleTapOnShowGlobalToastButton()
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
