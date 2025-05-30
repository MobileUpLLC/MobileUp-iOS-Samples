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
    
    func onShowBottomSheetButtonTapped() {
        isBottomSheetPresented = true
    }
    
    func onShowExamplesModuleButtonTapped() {
        Task { [weak self] in
            await self?.coordinator.showExampleModule()
        }
    }
    
    func handleShowAlertButtonTapped() {
        isLogoutAlertPresented = true
    }
    
    func handleAlertLogoutButtonTapped() {
        do {
            try authRepository.clearKeychainDataInStorage()
            isLogoutAlertPresented = true
            coordinator.showEntrance()
        } catch {
            coordinator.showErrorToast(with: error)
        }
    }
    
    func onShowSkeletonButtonTapped() {
        isBottomSheetPresented = false
        
        onMainAfter(deadline: .now() + .one) { [weak self] in
            self?.coordinator.showSkeletonModule()
        }
    }
}
