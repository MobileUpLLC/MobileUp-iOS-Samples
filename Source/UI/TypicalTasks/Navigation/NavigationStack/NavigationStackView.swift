import SwiftUI

struct NavigationStackView: View {
    @ObservedObject var viewModel: NavigationStackViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(R.string.navigation.navigationStackTitle())
                .font(UIFont.Heading.primary.asFont)
                .foregroundStyle(.black)
                .padding(.vertical, 20)
                .padding(.horizontal, 28)
            Group {
                Button(R.string.navigation.navigationPushControllerButton()) {
                    viewModel.onPushControllerButtonTapped()
                }
                Button(R.string.navigation.navigationPopControllerButton()) {
                    viewModel.onPopControllerButtonTapped()
                }
                Button(R.string.navigation.navigationPopToRootButton()) {
                    viewModel.onPopToRootControllerButtonTapped()
                }
                Button(R.string.navigation.navigationPopToNavigationControllerButton()) {
                    viewModel.onPopToNavigationControllerButtonTapped()
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
    NavigationStackView(
        viewModel: NavigationStackViewModel(
            coordinator: NavigationStackCoordinator()
        )
    )
}
