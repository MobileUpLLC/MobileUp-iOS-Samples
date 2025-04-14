import SwiftUI

struct PresentationExampleView: View {
    @ObservedObject var viewModel: PresentationExampleViewModel
    
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
    PresentationExampleView(
        viewModel: PresentationExampleViewModel(
            coordinator: PresentationExampleCoordinator()
        )
    )
}
