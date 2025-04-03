import Foundation

final class NavigationViewModel: ObservableObject {
    @Published var textFromNextModule: String?
    @Published var isShareSheetShown = false
    @Published var isBottomSheetPresented = false
    
    var navigationItems: [NavigationViewItem] = []
    var shareSheetItems: [Any] = []
    
    private let coordinator: NavigationCoordinator
    private let navigationRepository: NavigationRepository
    
    init(coordinator: NavigationCoordinator, navigationRepository: NavigationRepository) {
        self.coordinator = coordinator
        self.navigationRepository = navigationRepository
        
        navigationItems = getNavigationItems()
        
        self.navigationRepository.onTextSubmit = { [weak self] text in
            self?.textFromNextModule = text
        }
    }
    
    func onItemTap(item: NavigationViewItem) {
        item.action()
    }
    
    func onShowSkeletonButtonTapped() {
        isBottomSheetPresented = false
        
        onMainAfter(deadline: .now() + .one) { [weak self] in
            self?.coordinator.showSkeletonModule()
        }
    }
    
    private func showNavigationStackModule() {
        coordinator.showNavigationStackModule()
    }
    
    private func showPresentationModule() {
        coordinator.showPresentationModule()
    }
    
    private func showDataTransferModule() {
        coordinator.showDataTransferModule { [weak self] text in
            self?.textFromNextModule = text
        }
    }
    
    private func showShareSheet() {
        let shareMessage = R.string.navigation.shareSheetMessage()
        
        shareSheetItems = [shareMessage]
        isShareSheetShown = true
    }
    
    private func showBottomSheet() {
        isBottomSheetPresented = true
    }
    
    private func showMultipleBottomSheetModule() {
        coordinator.showMultipleBottomSheetModule()
    }
    
    private func getNavigationItems() -> [NavigationViewItem] {
        return [
            .init(
                title: R.string.navigation.navigationStackTitle(),
                action: { [weak self] in
                    self?.showNavigationStackModule()
                }
            ),
            .init(
                title: R.string.navigation.presentationTitle(),
                action: { [weak self] in
                    self?.showPresentationModule()
                }
            ),
            .init(
                title: R.string.navigation.dataTransferTitle(),
                action: { [weak self] in
                    self?.showDataTransferModule()
                }
            ),
            .init(
                title: R.string.navigation.shareSheetTitle(),
                action: { [weak self] in
                    self?.showShareSheet()
                }
            ),
            .init(
                title: R.string.navigation.bottomSheetTitle(),
                action: { [weak self] in
                    self?.showBottomSheet()
                }
            ),
            .init(
                title: R.string.navigation.multipleBottomSheetTitle(),
                action: { [weak self] in
                    self?.showMultipleBottomSheetModule()
                }
            )
        ]
    }
}
