import SwiftUI

final class SkeletonViewModel: ObservableObject {
    private enum Constants {
        static let loadingDelay: Double = 3
    }
    
    @Published var isLoading = true
    
    init() {
        Log.skeletonViewModel.debug(logEntry: .text("init skeletonViewModel"))
        
        onMainAfter(deadline: .now() + Constants.loadingDelay) { [weak self] in
            self?.isLoading = false
        }
    }
    
    deinit {
        Log.skeletonViewModel.debug(logEntry: .text("deinit skeletonViewModel"))
    }
}
