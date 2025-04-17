import Foundation

final class BottomSheetExampleViewModel: ObservableObject {
    @Published var isBottomSheetPresented = false
    @Published var isLogoutAlertPresented = false
    @Published var isDeleteAlertPresented = false
    
    private let coordinator: BottomSheetExampleCoordinator
    private let authRepository: AuthRepository

    init(coordinator: BottomSheetExampleCoordinator, authRepository: AuthRepository) {
        self.coordinator = coordinator
        self.authRepository = authRepository
    }
    
    func handleTapOnShowBottomSheetButton() {
        isBottomSheetPresented = true
    }
    
    func handleTapOnShowExamplesModuleButton() {
        coordinator.showExampleModule()
    }
    
    func handleTapOnShowAlertButton() {
        isLogoutAlertPresented = true
    }
    
    func handleTapOnAlertLogoutButton() {
        isDeleteAlertPresented = true
    }
    
    func handleTapOnDeleteAlertLogoutButton() {
        do {
            try authRepository.clearKeychainDataInStorage()
        } catch {
            coordinator.showErrorToast(with: error)
        }
    }
    
    func handleTapOnShowSkeletonButton() {
        isBottomSheetPresented = false
        
        // Задержка нужна, чтобы успевать закрыть предыдущий боттом шит
        onMainAfter(deadline: .now() + .one) { [weak self] in
            self?.coordinator.showSkeletonModule()
        }
    }
}
