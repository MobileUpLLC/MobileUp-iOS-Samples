import Foundation

final class MultipleBottomSheetExampleViewModel: ObservableObject {
    enum BottomSheet: Identifiable {
        case greenSheet
        case blueSheet
        
        var id: Self { self }
    }
    
    @Published var bottomSheet: BottomSheet?
    
    private let coordinator: MultipleBottomSheetExampleCoordinator

    init(coordinator: MultipleBottomSheetExampleCoordinator) {
        self.coordinator = coordinator
    }
    
    func handleTapOnShowBlueSheetButton() {
        bottomSheet = .blueSheet
    }
    
    func handleTapOnShowGreenSheetButton() {
        bottomSheet = .greenSheet
    }
}
