import SwiftUI
import TipKit

struct OnboardingWithElementFocusView: View {
    @ObservedObject var viewModel: OnboardingWithElementFocusViewModel

    var body: some View {
        VStack {
            Text("OnboardingWithElementFocus module created!")
            if #available(iOS 17.0, *) {
                TipView(OnboardingTip())
                    .tipViewStyle(OnboardingTipViewStyle())
                    .frame(width: 300)
                    .symbolRenderingMode(.multicolor)
                    .tipCornerRadius(30)
                    .padding(20)
            }
        }
    }
}

#Preview {
    OnboardingWithElementFocusView(
        viewModel: OnboardingWithElementFocusViewModel(
            coordinator: OnboardingWithElementFocusCoordinator()
        )
    )
}
