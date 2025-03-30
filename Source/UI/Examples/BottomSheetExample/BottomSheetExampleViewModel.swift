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
        coordinator.showExampleModule()
    }
    
    func onShowAlertButtonTapped() {
        isLogoutAlertPresented = true
    }
    
    func onAlertLogoutButtonTapped() {
        isDeleteAlertPresented = true
    }
    
    func onDeleteAccountButtonTapped() {
        // TODO: UPUP-1022 Добавить чистку кейчейна
    }
    
    func onShowSkeletonButtonTapped() {
        isBottomSheetPresented = false
        
        onMainAfter(deadline: .now() + .one) { [weak self] in
            self?.coordinator.showSkeletonModule()
        }
    }
}
