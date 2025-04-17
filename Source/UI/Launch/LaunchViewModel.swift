import SwiftUI

final class LaunchViewModel: ObservableObject {
    private let coordinator: LaunchCoordinator

    init(coordinator: LaunchCoordinator) {
        self.coordinator = coordinator
    }
    
    func handleTapOnGoToTabbarButton() {
        coordinator.showTabbarModule()
    }
}
