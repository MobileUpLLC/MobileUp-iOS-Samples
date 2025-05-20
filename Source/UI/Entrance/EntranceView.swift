import SwiftUI

struct EntranceView: View {
    @ObservedObject var viewModel: EntranceViewModel
    
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            R.image.mobileUpLogo.image
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 0) {
                Spacer()
                if isAnimating {
                    VStack(spacing: 12) {
                        Button(R.string.entrance.entranceRegistrationButtonTitle()) {
                            viewModel.onRegistrationButtonTapped()
                        }
                        Button(R.string.entrance.entranceAuthorizationButtonTitle()) {
                            viewModel.onAuthorizationButtonTapped()
                        }
                    }
                }
            }
            .transition(.move(edge: .bottom))
            .padding(.horizontal, 20)
            .padding(.bottom, 34)
        }
        .background(.white)
        .animation(.easeOut(duration: 0.3), value: isAnimating)
        .onAppear { isAnimating = true }
        .ignoresSafeArea()
    }
}

#Preview {
    EntranceView(
        viewModel: EntranceViewModel(
            coordinator: EntranceCoordinator()
        )
    )
}
