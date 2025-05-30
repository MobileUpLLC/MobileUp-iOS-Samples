import Foundation

final class SignInPhoneViewModel: ViewModel {
    private enum Constants {
        static let hideErrorDelay = 1.0
        static let resendCodeInterval: TimeInterval = 90
    }
    
    @Published var phoneNumber = String.empty
    @Published var isPhoneNumberValid = false
    @Published var isLoading = false
    @Published var isError = false
    @Published var isLegalInfoSheetShown = false
    @Published var smsCoolDown = String.empty
            
    let legalInfo: String
    
    private let coordinator: SignInPhoneCoordinator
    private let authRepository: AuthRepository
    
    init(
        coordinator: SignInPhoneCoordinator,
        authRepository: AuthRepository
    ) {
        self.coordinator = coordinator
        self.authRepository = authRepository

        legalInfo = .empty
        
        super.init()
    }
    
    func handleBackButtonTap() {
        coordinator.goBack()
    }
    
    func handleSaveButtonTap() {
        authorize()
    }
    
    private func showTabBarScreen() {
        Task { [weak self] in
            await self?.coordinator.showTabBarScreen()
        }
    }
    
    private func authorize() {
        isLoading = true
        
        let phone = phoneNumber.removeExtraPhoneSymbols()
        
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            let request = PhoneAuthRequest(phoneNumber: phone)
            try await authRepository.authorizeUserWithPhone(with: request)
            
            onMain { [weak self] in
                self?.coordinator.showConfirmationScreen(
                    with: phone,
                    resendCodeInterval: Constants.resendCodeInterval
                )
            }
        }
    }
    
    private func showLegalInfoSheet() {
        isLegalInfoSheetShown = true
    }
}
