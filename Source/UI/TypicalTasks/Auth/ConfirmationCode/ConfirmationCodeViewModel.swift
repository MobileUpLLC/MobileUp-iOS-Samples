import Foundation

enum ConfirmCodeViewState {
    case initial
    case loading
    case loadingOnResend
    case valid
    case error
}

enum ConfirmationCodeDisplayType {
   case push
   case present
}

final class ConfirmationCodeViewModel: ViewModel {
    @Published var code: String = .empty
    @Published var codeOTPBlockState: OTPInputViewState = .input
    @Published private(set) var state: ConfirmCodeViewState
    @Published var sendCodeCooldown: String = .empty
    
    let credentials: String
    let displayType: ConfirmationCodeDisplayType
    
    private let coordinator: ConfirmationCodeCoordinator
    private let authRepository: AuthRepository
    private let timerService: TimerService
    private let dateComponentsFormatter = DateComponentsFormatter()
    
    init(
        credentials: String,
        displayType: ConfirmationCodeDisplayType,
        coordinator: ConfirmationCodeCoordinator,
        authRepository: AuthRepository,
        timerService: TimerService
    ) {
        self.credentials = credentials
        self.displayType = displayType
        self.coordinator = coordinator
        self.authRepository = authRepository
        self.timerService = timerService
        state = .initial
        
        super.init()
        
        setupDateComponentsFormatter()
        
        timerService.onRemainingTimeChangeAction = { [weak self] remainingTimeComponents in
            self?.updateCodeCooldown(with: remainingTimeComponents)
        }
        
        if timerService.getRemainingTime == nil {
            timerService.startTimer()
        }
    }
    
    func handleResendButtonTap() {
        resendConfirmationCode()
    }
    
    func sendCodeIfNeeded(code: String) {
        guard code.count == .four else {
            return
        }
        
        state = .loading
        codeOTPBlockState = .validation
        
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            let request = ConfirmationCodeRequest(confirmationCode: code)
            
            try await authRepository.checkConfirmationСode(with: request)
            
            onMain { [weak self] in
                self?.state = .valid
                self?.codeOTPBlockState = .valid
            }
            onMainAfter(deadline: .now() + 1) { [weak self] in
                self?.clearOTPView()
                self?.handleSuccessValidation()
            }
        } onError: { [weak self] error in
            self?.state = .error
            self?.codeOTPBlockState = .error
            
            switch error {
            case .statusCode(let response):
                if response.statusCode == 429 {
                    self?.coordinator.showErrorToast(with: R.string.common.errorStateTitle())
                }
            default:
                let message = R.string.auth.confirmationCodeInvalidCode()
                self?.coordinator.showErrorToast(with: message)
            }
            
            HapticFeedbackUtil.generate(.notification(.error))
            
            onMainAfter(deadline: .now() + 1) { [weak self] in
                self?.clearOTPView()
            }
        }
    }
    
    private func handleSuccessValidation() {
        close { [weak self] in
            guard let self else {
                return
            }
            
            Task { [weak self] in
                await self?.coordinator.showTabBarScreen()
            }
        }
    }
    
    private func updateCodeCooldown(with newRemainingTimeComponents: DateComponents?) {
        var remainingTime: String = .empty
        
        if
            let newRemainingTimeComponents,
            let newRemainingTime = dateComponentsFormatter.string(from: newRemainingTimeComponents)
        {
            remainingTime = newRemainingTime
        }
        
        sendCodeCooldown = remainingTime
    }
    
    private func close(onCloseAction: Closure.Void? = nil) {
        switch displayType {
        case .push:
            onCloseAction?()
            coordinator.pop()
        case .present:
            coordinator.dismiss()
        }
    }
    
    private func resendConfirmationCode() {
        state = .loadingOnResend
        
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            let request = EmailRequest(email: credentials)
            try await authRepository.sendRecoveryConfirmationCode(with: request)
                        
            onMain { [weak self] in
                self?.state = .initial
                
                if self?.timerService.getRemainingTime == nil {
                    self?.timerService.startTimer()
                }
            }
        } onError: { [weak self] error in
            self?.state = .initial
            
            switch error {
            case .statusCode(let response):
                if response.statusCode == 429 {
                    self?.coordinator.showErrorToast(with: R.string.common.errorStateTitle())
                }
            default:
                self?.coordinator.showErrorToast()
            }
        }
    }
    
    private func setupDateComponentsFormatter() {
        dateComponentsFormatter.allowedUnits = [.minute, .second]
        dateComponentsFormatter.unitsStyle = .positional
        dateComponentsFormatter.zeroFormattingBehavior = .pad
    }
    
    private func clearOTPView() {
        code = .empty
        codeOTPBlockState = .input
    }
}
