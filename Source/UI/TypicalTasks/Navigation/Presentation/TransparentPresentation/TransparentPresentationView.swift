import SwiftUI

struct TransparentPresentationView: View {
    @ObservedObject var viewModel: TransparentPresentationViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(systemName: "photo")
                .resizable()
                .frame(width: 120, height: 80)
                .scaledToFit()
                .foregroundStyle(.blue)
            Button(R.string.common.closeButtonTitle()) {
                viewModel.onCloseButtonTapped()
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .padding()
        }
        .background(.clear)
    }
}

#Preview {
    TransparentPresentationView(
        viewModel: TransparentPresentationViewModel(
            coordinator: TransparentPresentationCoordinator()
        )
    )
}
