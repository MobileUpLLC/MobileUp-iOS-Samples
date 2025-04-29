import SwiftUI

final class TabbarViewModel: ObservableObject {
    private let coordinator: TabBarCoordinator
    private let pushService: PushService
    private let networkService: NetworkService

    init(
        coordinator: TabBarCoordinator,
        pushService: PushService,
        networkService: NetworkService
    ) {
        self.coordinator = coordinator
        self.pushService = pushService
        self.networkService = networkService

        pushService.onPushReceive = { [weak self] model in
            self?.onPushTapped(model: model)
        }
    }
    
    func viewDidAppear() {
        Task {
            _ = try? await pushService.requestAuthorization()
        }
    }

    private func onPushTapped(model: PushPayloadModel) {
        coordinator.openBottomSheet()
    }
    
    deinit {
        Log.refreshTokenFlow.debug(logEntry: .text("TabbarViewModel. deinit"))
    }
}
