import Foundation

final class ComplexUIComponentsViewModel: ObservableObject {
    private let coordinator: ComplexUIComponentsCoordinator
    
    init(coordinator: ComplexUIComponentsCoordinator) {
        self.coordinator = coordinator
    }
    
    func showTypicalTabBar() {
        coordinator.showTypicalTabBar()
    }
}
