import Foundation

final class NavigationViewModel: ObservableObject {
    @Published var textFromNextModule: String?
    
    var navigationItems: [NavigationViewItem] = []
    
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
            )
        ]
    }
}
