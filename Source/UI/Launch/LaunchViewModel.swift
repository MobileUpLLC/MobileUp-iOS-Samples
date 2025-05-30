import SwiftUI

final class LaunchViewModel: ObservableObject {
    private let coordinator: LaunchCoordinator
    private let networkService: NetworkService

    init(coordinator: LaunchCoordinator, networkService: NetworkService) {
        self.coordinator = coordinator
        self.networkService = networkService
    }

    func onGoToTabbarButtonTapped() {
        Task { [weak self] in await
            self?.coordinator.showTabbarModule(networkService: networkService)
        }
    }
}
