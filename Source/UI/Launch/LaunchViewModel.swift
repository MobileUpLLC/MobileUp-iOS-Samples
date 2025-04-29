import SwiftUI

final class LaunchViewModel: ObservableObject {
    private let coordinator: LaunchCoordinator
    private let networkService: NetworkService

    init(coordinator: LaunchCoordinator, networkService: NetworkService) {
        self.coordinator = coordinator
        self.networkService = networkService
    }

    func onGoToTabbarButtonTapped() {
        coordinator.showTabbarModule(networkService: networkService)
    }
}
