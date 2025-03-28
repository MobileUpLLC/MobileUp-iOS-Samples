import SwiftUI

struct LaunchView: View {
    @ObservedObject var viewModel: LaunchViewModel

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            Button("Go to tabbar") {
                viewModel.onGoToTabbarButtonTapped()
            }
        }
    }
}

#Preview {
    LaunchView(viewModel: .init(coordinator: .init()))
}
