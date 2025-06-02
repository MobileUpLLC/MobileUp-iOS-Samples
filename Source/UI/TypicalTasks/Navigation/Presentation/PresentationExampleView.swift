import SwiftUI

struct PresentationExampleView: View {
    @ObservedObject var viewModel: PresentationExampleViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(R.string.navigation.presentationModuleDemoTitle())
                .font(UIFont.Heading.primary.asFont)
                .foregroundStyle(.black)
                .padding(.vertical, 20)
                .padding(.horizontal, 28)
            Group {
                Button(R.string.navigation.presentationPresentFullScreenControllerButton()) {
                    viewModel.handleTapOnShowFullScreenControllerButton()
                }
                Button(R.string.navigation.presentationPresentTransparentFullScreenControllerButton()) {
                    viewModel.handleTapOnShowTransparentFullScreenControllerButton()
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
