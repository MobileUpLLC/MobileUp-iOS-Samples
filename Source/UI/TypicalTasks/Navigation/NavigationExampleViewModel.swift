import Foundation

final class NavigationExampleViewModel: ObservableObject {
    @Published var textFromNextModule: String?
    @Published var isShareSheetShown = false
    @Published var isBottomSheetPresented = false
    @Published var isScrollableBottomSheetPresented = false
    @Published var isAlertPresented = false
    
    var navigationItems: [NavigationExampleViewItem] = []
    var shareSheetItems: [Any] = []
    
    private let coordinator: NavigationExampleCoordinator
    private let navigationRepository: NavigationRepository
    
    init(coordinator: NavigationExampleCoordinator, navigationRepository: NavigationRepository) {
        self.coordinator = coordinator
        self.navigationRepository = navigationRepository
        
        navigationItems = getNavigationItems()
        
        self.navigationRepository.onTextSubmit = { [weak self] text in
            self?.textFromNextModule = text
        }
    }
    
    func onShowSkeletonButtonTapped() {
        isBottomSheetPresented = false
        
        // Задержка нужна, чтобы успевать закрыть предыдущий боттом шит
        onMainAfter(deadline: .now() + .one) { [weak self] in
            self?.coordinator.showSkeletonModule()
        }
    }
    
    func onAlertButtonTapped() {
        isAlertPresented = false
    }
    
    private func showNavigationStackExampleModule() {
        coordinator.showNavigationStackExampleModule()
    }
    
    private func showPresentationExampleModule() {
        coordinator.showPresentationExampleModule()
    }
    
    private func showDataTransferExampleModule() {
        coordinator.showDataTransferExampleModule { [weak self] text in
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
    
    private func showScrollableBottomSheet() {
        isScrollableBottomSheetPresented = true
    }
    
    private func showToastExample() {
        coordinator.showToastExampleModule()
    }
    
    private func showAlert() {
        isAlertPresented = true
    }
    
    // swiftlint:disable function_body_length
    private func getNavigationItems() -> [NavigationExampleViewItem] {
        return [
            .init(
                title: R.string.navigation.navigationStackTitle(),
                action: { [weak self] in
                    self?.showNavigationStackExampleModule()
                }
            ),
            .init(
                title: R.string.navigation.presentationTitle(),
                action: { [weak self] in
                    self?.showPresentationExampleModule()
                }
            ),
            .init(
                title: R.string.navigation.dataTransferTitle(),
                action: { [weak self] in
                    self?.showDataTransferExampleModule()
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
            ),
            .init(
                title: R.string.navigation.bottomSheetWithScrollTitle(),
                action: { [weak self] in
                    self?.showScrollableBottomSheet()
                }
            ),
            .init(
                title: R.string.navigation.toastTitle(),
                action: { [weak self] in
                    self?.showToastExample()
                }
            ),
            .init(
                title: R.string.navigation.showAlertTitle(),
                action: { [weak self] in
                    self?.showAlert()
                }
            )
        ]
    }
    // swiftlint:enable function_body_length
}
