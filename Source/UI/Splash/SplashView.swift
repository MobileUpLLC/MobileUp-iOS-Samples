import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel: SplashViewModel

    var body: some View {
        R.image.mobileUpLogo.image
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .ignoresSafeArea(.all, edges: .all)
    }
}

#Preview {
    SplashView(
        viewModel: SplashViewModel(
            coordinator: SplashCoordinator(),
            networkService: .init(),
            authRepository: AuthRepository(networkService: .init()),
            completion: { _ in }
        )
    )
}
