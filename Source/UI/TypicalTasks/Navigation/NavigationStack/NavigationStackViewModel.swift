import Foundation

final class NavigationStackViewModel: ObservableObject {
    private let coordinator: NavigationStackCoordinator
    
    init(coordinator: NavigationStackCoordinator) {
        self.coordinator = coordinator
    }
    
    func onPushControllerButtonTapped() {
        coordinator.showNavigationStackController()
    }
    
    func onPopControllerButtonTapped() {
        coordinator.pop()
    }
    
    func onPopToRootControllerButtonTapped() {
        coordinator.popToRoot()
    }
    
    func onPopToNavigationControllerButtonTapped() {
        coordinator.popToNavigationController()
    }
}
