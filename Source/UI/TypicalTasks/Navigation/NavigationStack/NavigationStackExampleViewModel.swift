import Foundation

final class NavigationStackExampleViewModel: ObservableObject {
    private let coordinator: NavigationStackExampleCoordinator
    
    init(coordinator: NavigationStackExampleCoordinator) {
        self.coordinator = coordinator
    }
    
    func handleTapOnPushControllerButton() {
        coordinator.showNavigationStackExampleController()
    }
    
    func handleTapOnPopControllerButton() {
        coordinator.popToPreviousController()
    }
    
    func handleTapOnPopToRootControllerButton() {
        coordinator.popToTypicalTasksController()
    }
    
    func handleTapOnPopToNavigationControllerButton() {
        coordinator.popToNavigationExampleController()
    }
}
