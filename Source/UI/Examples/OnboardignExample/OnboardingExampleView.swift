import SwiftUI

struct OnboardingExampleView: View {
    @ObservedObject var viewModel: OnboardingExampleViewModel

    var body: some View {
        VStack {
            Button {
                viewModel.showCommonOnboardingScreen()
            } label: {
                Text(R.string.examples.onboardingShowCommonOnboardingButtonTitle())
                    .padding(10)
                    .background(.gray)
                    .roundedCorner(5, corners: .allCorners)
            }
            Button {
                viewModel.showOnboardingWithElementFocus()
            } label: {
                Text(R.string.examples.onboardingShowOnboardingWithElementFocusButtonTitle())
                    .padding(10)
                    .background(.gray)
                    .roundedCorner(5, corners: .allCorners)
            }
        }
    }
}

#Preview {
    OnboardingExampleView(
        viewModel: OnboardingExampleViewModel(
            coordinator: OnboardingExampleCoordinator()
        )
    )
}
