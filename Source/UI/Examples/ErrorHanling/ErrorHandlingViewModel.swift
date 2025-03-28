import Foundation

final class ErrorHandlingViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isError = false
    
    init() {
        getMockData()
    }
    
    func onRetryButtonTapped() {
        getMockData()
    }
    
    private func getMockData() {
        isError = false
        isLoading = true
        
        Perform {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            
            throw URLError(.unknown)
        } onError: { [weak self] _ in
            self?.isError = true
            self?.isLoading = false
        }
    }
}
