import Foundation

final class RootViewModel: ViewModel {
    private let coordinator: RootCoordinator
    private let flow: InitialNavigationFlow
    
    init(coordinator: RootCoordinator, flow: InitialNavigationFlow) {
        self.coordinator = coordinator
        self.flow = flow
    }
    
    func handleViewDidLoad() {
        switch flow {
        case .entrance:
            coordinator.showEntrance()
        case .tabBar:
            Task { [weak self] in
                await self?.coordinator.showTabBar()
            }
        }
    }
}
