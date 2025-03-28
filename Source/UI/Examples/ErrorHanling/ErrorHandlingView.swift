import SwiftUI

struct ErrorHandlingView: View {
    @ObservedObject var viewModel: ErrorHandlingViewModel

    var body: some View {
        Color.white
            .ignoresSafeArea()
            .skeleton(isLoading: viewModel.isLoading) {
                SkeletonContentView()
            }
            .errorState(isError: viewModel.isError) {
                ErrorView(onRetry: viewModel.onRetryButtonTapped)
            }
    }
}
