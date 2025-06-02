import SwiftUI

struct TransparentPresentationExampleView: View {
    @ObservedObject var viewModel: TransparentPresentationExampleViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(systemName: "photo")
                .resizable()
                .frame(width: 120, height: 80)
                .scaledToFit()
                .foregroundStyle(.blue)
            Button(R.string.common.closeButtonTitle()) {
                viewModel.handleTapOnCloseButton()
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .padding()
        }
        .background(.clear)
    }
}

#Preview {
    TransparentPresentationExampleView(
        viewModel: TransparentPresentationExampleViewModel(
            coordinator: TransparentPresentationExampleCoordinator()
        )
    )
}
