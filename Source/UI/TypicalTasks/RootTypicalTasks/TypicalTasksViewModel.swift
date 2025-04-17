import Foundation

final class TypicalTasksViewModel: ViewModel {
    @Published var isDeleteAlertPresented = false
    @Published var isSuccessAuthAlertPresented = false
    @Published var isNotAuthAlertPresented = false
    
    private let coordinator: TypicalTasksCoordinator
    private let authRepository: AuthRepository
    
    var typicalTasks: [TypicalTasksViewItem] = []
    
    init(coordinator: TypicalTasksCoordinator, authRepository: AuthRepository) {
        self.coordinator = coordinator
        self.authRepository = authRepository
        
        super.init()
        
        typicalTasks = getTypicalTasks()
    }
    
    func onItemTap(item: TypicalTasksViewItem) {
        item.action()
    }
    
    func showDeleteAccountAlert() {
        isDeleteAlertPresented = true
    }
    
    func handleTapOnLimitedByAuthButton() {
        if authRepository.isUserAuthorized {
            isSuccessAuthAlertPresented = true
        } else {
            isNotAuthAlertPresented = true
        }
    }
    
    func handleTapOnDeleteAlertLogoutButton() {
        do {
            try authRepository.clearKeychainDataInStorage()
            coordinator.showEntrance()
        } catch {
            coordinator.showErrorToast(with: error)
        }
    }
    
    func clearUserData() {
        do {
            try authRepository.clearKeychainDataInStorage()
        } catch {
            coordinator.showErrorToast(with: error)
        }
    }
    
    func openSignInPhoneModule() {
        coordinator.showSignInPhone()
    }
    
    func openEntranceModule() {
        coordinator.showEntrance()
    }
    
    private func showAuthorizationModule() {
        coordinator.showAuthorizationModule()
    }
    
    private func showRegistrationModule() {
        coordinator.showRegistrationModule()
    }
    
    private func showNavigationExampleModule() {
        coordinator.showNavigationExampleModule()
    }
    
    private func getTypicalTasks() -> [TypicalTasksViewItem] {
        return [
            .init(
                title: R.string.typicalTasks.typicalTasksAuthorization(),
                action: { [weak self] in
                    self?.showAuthorizationModule()
                }
            ),
            .init(
                title: R.string.typicalTasks.typicalTasksRegistration(),
                action: { [weak self] in
                    self?.showRegistrationModule()
                }
            ),
            .init(
                title: R.string.typicalTasks.typicalTasksDeleteAccountSheetTitle(),
                action: { [weak self] in
                    self?.showDeleteAccountAlert()
                }
            ),
            .init(
                title: R.string.typicalTasks.typicalTasksLimitedByAuthTitle(),
                action: { [weak self] in
                    self?.handleTapOnLimitedByAuthButton()
                }
            ),
            .init(
                title: R.string.typicalTasks.typicalTasksPhoneAuthorization(),
                action: { [weak self] in
                    self?.openSignInPhoneModule()
                }
            ),
            .init(
                title: R.string.typicalTasks.typicalTasksNavigation(),
                action: { [weak self] in
                    self?.showNavigationExampleModule()
                }
            )
        ]
    }
}
