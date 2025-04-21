import SwiftUI

struct OnboardingWithElementFocusView: View {
    @ObservedObject var viewModel: OnboardingWithElementFocusViewModel

    var body: some View {
        Text("OnboardingWithElementFocus module created!")
    }
}

#Preview {
    OnboardingWithElementFocusView(
        viewModel: OnboardingWithElementFocusViewModel(
            coordinator: OnboardingWithElementFocusCoordinator()
        )
    )
}
