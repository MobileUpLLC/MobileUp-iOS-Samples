import Foundation
import FormView

final class RegistrationViewModel: ViewModel {
    private enum Constants {
        static let resendCodeInterval: TimeInterval = 90
    }
    
    @Published var email: String = .empty
    @Published var password: String = .empty
    @Published var confirmPassword: String = .empty
    @Published var outerEmailRules: [OuterValidationRule] = []
    @Published var outerPasswordRules: [OuterValidationRule] = []
    @Published var isLoading = false
    
    var termsLink: String { Environments.termsOfUseUrl.absoluteString }
    var privacyLink: String { Environments.privacyPolicyUrl.absoluteString }
    
    private let coordinator: RegistrationCoordinator
    private let authRepository: AuthRepository
    
    init(
        coordinator: RegistrationCoordinator,
        authRepository: AuthRepository
    ) {
        self.coordinator = coordinator
        self.authRepository = authRepository
        
        super.init()
    }

    func handleNextButtonTapped() {
        guard authRepository.refreshToken != nil else {
            authorizeUserDevice(completion: { [weak self] in self?.register() })
            return
        }
        
        register()
    }
    
    func handleFailedValid() {
        isLoading = false
    }
    
    func handleLinkTap(with url: String) {
        if url == termsLink {
            showTermsOfUse()
        } else if url == privacyLink {
            showPrivacyPolicy()
        }
    }
    
    private func authorizeUserDevice(completion: @escaping Closure.Void) {
        isLoading = true
        
        Perform { [weak self] in
            try await self?.authRepository.authorizeUserDevice()
            
            onMain(execute: completion)
        } onError: { [weak self] _ in
            self?.isLoading = false
            self?.coordinator.showErrorToast()
        }
    }
    
    private func showTermsOfUse() {
        let model = WebPageModel(
            url: URL(string: termsLink),
            navigationTitle: R.string.common.documentsTermsOfUseButtonTitle()
        )
        
        coordinator.openWebDocument(with: model)
    }
    
    private func showPrivacyPolicy() {
        let model = WebPageModel(
            url: URL(string: privacyLink),
            navigationTitle: R.string.common.documentsPrivacyPolicyButtonTitle()
        )
        
        coordinator.openWebDocument(with: model)
    }
    
    private func register() {
        isLoading = true
        
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            let request = EmailAuthRequest(email: email, password: password)
            try await authRepository.register(with: request)
            onMain { [weak self] in
                self?.isLoading = false
                guard let email = self?.email, email.isEmpty == false else {
                    return
                }
                self?.coordinator.showConfirmationScreen(
                    with: email,
                    resendCodeInterval: Constants.resendCodeInterval
                )
            }
        } onError: { [weak self] serverError in
            self?.isLoading = false
            
            if serverError.response?.statusCode == 422 {
                self?.outerEmailRules = [.emailAlreadyExists]
            } else {
                self?.coordinator.showErrorToast()
            }
        }
    }
}
