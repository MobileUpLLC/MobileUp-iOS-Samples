import Foundation

final class NavigationStackExampleViewModel: ObservableObject {
    private let coordinator: NavigationStackExampleCoordinator
    
    init(coordinator: NavigationStackExampleCoordinator) {
        self.coordinator = coordinator
    }
    
    func onPushControllerButtonTapped() {
        coordinator.showNavigationStackExampleController()
    }
    
    func onPopControllerButtonTapped() {
        coordinator.popToPreviousController()
    }
    
    func onPopToRootControllerButtonTapped() {
        coordinator.popToTypicalTasksController()
    }
    
    func onPopToNavigationControllerButtonTapped() {
        coordinator.popToNavigationExampleController()
    }
}
