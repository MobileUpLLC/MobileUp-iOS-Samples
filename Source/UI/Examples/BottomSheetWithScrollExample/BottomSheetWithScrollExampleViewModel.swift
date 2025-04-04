import Foundation

final class BottomSheetWithScrollExampleViewModel: ObservableObject {
    @Published var scrollableBottomSheetItems: [String] = []
    
    private let coordinator: BottomSheetWithScrollExampleCoordinator
    
    init(coordinator: BottomSheetWithScrollExampleCoordinator) {
        self.coordinator = coordinator
        
        getScrollableBottomSheetItems()
    }
    
    private func getScrollableBottomSheetItems() {
        scrollableBottomSheetItems = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    }
}
