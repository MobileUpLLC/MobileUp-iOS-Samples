import SwiftUI

struct BottomSheetExampleView: View {
    @ObservedObject var viewModel: BottomSheetExampleViewModel
    
    var body: some View {
        ZStack {
            Color.white
            VStack(spacing: 20) {
                Button(R.string.examples.showExamplesButtonTitle()) {
                    viewModel.onShowExamplesModuleButtonTapped()
                }
                Button(R.string.examples.showBottomSheetButtonTitle()) {
                    viewModel.onShowBottomSheetButtonTapped()
                }
                Button(R.string.examples.showLogoutAlertButtonTitle()) {
                    viewModel.onShowAlertButtonTapped()
                }
            }
        }
        .overlay {
            Color.black
                .opacity(viewModel.isBottomSheetPresented ? 0.5 : 0)
                .animation(.linear(duration: 0.15), value: viewModel.isBottomSheetPresented)
                .onTapGesture {
                    viewModel.isBottomSheetPresented = false
                }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $viewModel.isBottomSheetPresented) {
            GreenBottomSheetView(showSkeletonButtonHandler: viewModel.onShowSkeletonButtonTapped)
                .enablePresentationBackgroundInteraction(upThrough: .medium)
        }
        .alert(
            R.string.examples.logoutAlertTitle(),
            isPresented: $viewModel.isLogoutAlertPresented,
            actions: {
                Button(R.string.examples.alertCancelButtonTitle()) {
                    viewModel.onShowBottomSheetButtonTapped()
                }
                Button(R.string.examples.alertLogoutButtonTitle()) {
                    viewModel.onAlertLogoutButtonTapped()
                }
            },
            message: { Text(R.string.examples.logoutAlertMessage()) }
        )
        .alert(
            "",
            isPresented: $viewModel.isDeleteAlertPresented,
            actions: {
                Button(R.string.examples.alertCancelButtonTitle(), role: .cancel) { }
                Button(R.string.examples.alertLogoutButtonTitle(), role: .destructive) { }
            },
            message: { Text(R.string.examples.secondAlertMessage()) }
        )
    }
}

struct GreenBottomSheetView: View {
    let showSkeletonButtonHandler: () -> Void
    
    var body: some View {
        ZStack {
            Color.green
                .opacity(0.5)
                .ignoresSafeArea()
            Button("Show skeleton") {
                showSkeletonButtonHandler()
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    BottomSheetExampleView(viewModel: .init(coordinator: .init()))
}
