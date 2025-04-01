import UIKit

enum ConfirmationCodeFactory {
    static func createConfirmationCodeController(
        email: String,
        resendCodeInterval: TimeInterval,
        displayType: ConfirmationCodeDisplayType
    ) -> ConfirmationCodeController {
        let coordinator = ConfirmationCodeCoordinator()
        let authRepository = AuthRepository()
        let timerService = TimerService(timerInterval: resendCodeInterval, timerUpdateRate: .one)
        let viewModel = ConfirmationCodeViewModel(
            email: email,
            displayType: displayType,
            coordinator: coordinator,
            authRepository: authRepository,
            timerService: timerService
        )
        let controller = ConfirmationCodeController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
