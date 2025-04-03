import SwiftUI

struct PresentationView: View {
    @ObservedObject var viewModel: PresentationViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(R.string.navigation.presentationTitle())
                .font(UIFont.Heading.primary.asFont)
                .foregroundStyle(.black)
                .padding(.vertical, 20)
                .padding(.horizontal, 28)
            Group {
                Button(R.string.navigation.presentationPresentFullScreenControllerButton()) {
                    viewModel.onShowFullScreenControllerButtonTapped()
                }
                Button(R.string.navigation.presentationPresentTransparentFullScreenControllerButton()) {
                    viewModel.onShowTransparentFullScreenControllerButtonTapped()
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
    PresentationView(
        viewModel: PresentationViewModel(
            coordinator: PresentationCoordinator()
        )
    )
}
