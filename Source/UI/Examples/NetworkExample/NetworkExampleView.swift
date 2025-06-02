import SwiftUI

struct NetworkExampleView: View {
    @ObservedObject var viewModel: NetworkExampleViewModel

    var body: some View {
        VStack(spacing: 50) {
            Text("Result: \(viewModel.restultText)")
            Button("Request") {
                viewModel.handleTapOnRequestDataButton()
            }
            Button("Cancel request") {
                viewModel.handleTapOnCancelRequestButton()
            }
        }
    }
}

#Preview {
    let viewModel = NetworkExampleViewModel(
        coordinator: NetworkExampleCoordinator(),
        networkService: .init()
    )
    
    return NetworkExampleView(viewModel: viewModel)
}
