import Foundation

final class BottomSheetExampleViewModel: ObservableObject {
    @Published var isBottomSheetPresented = false
    @Published var isLogoutAlertPresented = false
    @Published var isDeleteAlertPresented = false
    
    private let coordinator: BottomSheetExampleCoordinator

    init(coordinator: BottomSheetExampleCoordinator) {
        self.coordinator = coordinator
    }
    
    func onShowBottomSheetButtonTapped() {
        isBottomSheetPresented = true
    }
    
    func onShowExamplesModuleButtonTapped() {
        coordinator.showExampleModule()
    }
    
    func onShowAlertButtonTapped() {
        isLogoutAlertPresented = true
    }
    
    func onAlertLogoutButtonTapped() {
        isDeleteAlertPresented = true
    }
    
    func onShowSkeletonButtonTapped() {
        isBottomSheetPresented = false
        
        onMainAfter(deadline: .now() + .one) { [weak self] in
            self?.coordinator.showSkeletonModule()
        }
    }
}
