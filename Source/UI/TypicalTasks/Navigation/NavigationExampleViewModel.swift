import UIKit

final class NavigationExampleViewModel: ObservableObject {
    @Published var textFromNextModule: String?
    @Published var isShareSheetShown = false
    @Published var isBottomSheetPresented = false
    @Published var isScrollableBottomSheetPresented = false
    @Published var isAlertPresented = false
    
    private(set) var navigationItems: [NavigationExampleViewItem] = []
    private(set) var shareSheetItems: [Any] = []
    private(set) var shareSheetActivities: [UIActivity] = [CustomActivity()]
    
    private let coordinator: NavigationExampleCoordinator
    private let navigationRepository: NavigationRepository
    
    init(coordinator: NavigationExampleCoordinator, navigationRepository: NavigationRepository) {
        self.coordinator = coordinator
        self.navigationRepository = navigationRepository
        
        navigationItems = getNavigationItems()
        
        navigationRepository.onTextSubmit = { [weak self] text in
            self?.textFromNextModule = text
        }
    }
    
    func handleTapOnShowSkeletonButton() {
        isBottomSheetPresented = false
        
        // Задержка нужна, чтобы успевать закрыть предыдущий боттом шит, решение через onDismiss не подходит
        onMainAfter(deadline: .now() + .one) { [weak self] in
            self?.coordinator.showSkeletonModule()
        }
    }
    
    func handleTapOnAlertButton() {
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
                title: R.string.navigation.navigationStackButtonTitle(),
                action: { [weak self] in
                    self?.showNavigationStackExampleModule()
                }
            ),
            .init(
                title: R.string.navigation.presentationButtonTitle(),
                action: { [weak self] in
                    self?.showPresentationExampleModule()
                }
            ),
            .init(
                title: R.string.navigation.dataTransferButtonTitle(),
                action: { [weak self] in
                    self?.showDataTransferExampleModule()
                }
            ),
            .init(
                title: R.string.navigation.showShareSheetButtonTitle(),
                action: { [weak self] in
                    self?.showShareSheet()
                }
            ),
            .init(
                title: R.string.navigation.showBottomSheetButtonTitle(),
                action: { [weak self] in
                    self?.showBottomSheet()
                }
            ),
            .init(
                title: R.string.navigation.multipleBottomSheetButtonTitle(),
                action: { [weak self] in
                    self?.showMultipleBottomSheetModule()
                }
            ),
            .init(
                title: R.string.navigation.showBottomSheetWithScrollButtonTitle(),
                action: { [weak self] in
                    self?.showScrollableBottomSheet()
                }
            ),
            .init(
                title: R.string.navigation.toastButtonTitle(),
                action: { [weak self] in
                    self?.showToastExample()
                }
            ),
            .init(
                title: R.string.navigation.showAlertButtonTitle(),
                action: { [weak self] in
                    self?.showAlert()
                }
            )
        ]
    }
    // swiftlint:enable function_body_length
}
