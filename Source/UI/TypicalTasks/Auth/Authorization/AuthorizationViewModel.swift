import Foundation
import FormView

final class AuthorizationViewModel: ViewModel {
    @Published var isLoading = false
    @Published var email: String = .empty
    @Published var password: String = .empty
    @Published var outerEmailRules: [OuterValidationRule] = []
    @Published var outerPasswordRules: [OuterValidationRule] = []
    
    private let coordinator: AuthorizationCoordinator
    private let authRepository: AuthRepository
    
    init(
        coordinator: AuthorizationCoordinator,
        authRepository: AuthRepository
    ) {
        self.coordinator = coordinator
        self.authRepository = authRepository
    }
    
    func onForgotPasswordButtonTapped() {}
    
    func handleSignButtonTapped() {
        guard authRepository.refreshToken != nil else {
            authorizeUserDevice(completion: { [weak self] in self?.authorize() })
            return
        }
        
        authorize()
    }
    
    func handleFailedValid() {
        isLoading = false
    }
    
    private func authorizeUserDevice(completion: @escaping Closure.Void) {
        isLoading = true
        
        Perform { [weak self] in
            try await self?.authRepository.authorizeUserDevice()
            
            onMain(execute: completion)
        } onError: { [weak self] _ in
            self?.isLoading = false
        }
    }
    
    private func authorize() {
        isLoading = true
        
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            let request = EmailAuthRequest(email: email, password: password)
            try await authRepository.authorizeUserWithEmail(with: request)
            onMain { [weak self] in
                self?.showTabBarScreen()
            }
        } onError: { [weak self] error in
            guard let self else {
                return
            }
            
            isLoading = false
            switch error.response?.statusCode {
            case 201:
                confirmEmail(email)
            case 404:
                outerEmailRules = [.emailNotFound]
            case 422:
                outerPasswordRules = [.passwordInvalid]
            default:
                coordinator.showErrorToast(with: error)
            }
        }
    }
    
    private func confirmEmail(_ email: String) {
        isLoading = true
        
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            let emailRequest = EmailRequest(email: email)
            try await authRepository.sendRecoveryConfirmationCode(with: emailRequest)
            
            onMain { [weak self] in
                self?.coordinator.showConfirmCodeScreen(with: email)
            }
        } onError: { [weak self] error in
            self?.isLoading = false
            self?.coordinator.showErrorToast(with: error)
        }
    }
    
    private func showTabBarScreen() {
        Task { [weak self] in
            await self?.coordinator.showTabBarScreen()
        }
    }
}
