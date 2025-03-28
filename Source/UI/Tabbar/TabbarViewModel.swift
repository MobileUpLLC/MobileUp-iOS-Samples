import SwiftUI

final class TabbarViewModel: ObservableObject {
    private let coordinator: TabBarCoordinator
    private let pushService: PushService
    private let mobileService: MobileService
    
    init(
        coordinator: TabBarCoordinator,
        pushService: PushService,
        mobileService: MobileService
    ) {
        self.coordinator = coordinator
        self.pushService = pushService
        self.mobileService = mobileService
        
        pushService.onPushReceive = { [weak self] model in
            self?.onPushTapped(model: model)
        }
        
        mobileService.onTokenRefreshFailed = { [weak self] in
            onMain { [weak self] in
                // TODO: Handle logout
                self?.coordinator.openLaunch()
            }
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
