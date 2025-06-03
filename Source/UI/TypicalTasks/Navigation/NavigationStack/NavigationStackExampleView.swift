import SwiftUI

struct NavigationStackExampleView: View {
    @ObservedObject var viewModel: NavigationStackExampleViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(R.string.navigation.navigationStackModuleDemoTitle())
                .font(UIFont.Heading.primary.asFont)
                .foregroundStyle(.black)
                .padding(.vertical, 20)
                .padding(.horizontal, 28)
            Group {
                Button(R.string.navigation.navigationPushControllerButton()) {
                    viewModel.handleTapOnPushControllerButton()
                }
                Button(R.string.navigation.navigationPopControllerButton()) {
                    viewModel.handleTapOnPopControllerButton()
                }
                Button(R.string.navigation.navigationPopToRootButton()) {
                    viewModel.handleTapOnPopToRootControllerButton()
                }
                Button(R.string.navigation.navigationPopToNavigationControllerButton()) {
                    viewModel.handleTapOnPopToNavigationControllerButton()
                }
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            Spacer()
        }
        .background(.white)
    }
}

#Preview {
    NavigationStackExampleView(
        viewModel: NavigationStackExampleViewModel(
            coordinator: NavigationStackExampleCoordinator()
        )
    )
}
