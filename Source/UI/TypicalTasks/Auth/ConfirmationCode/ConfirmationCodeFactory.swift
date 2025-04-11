import UIKit

enum ConfirmationCodeFactory {
    static func createConfirmationCodeController(
        credentials: String,
        resendCodeInterval: TimeInterval,
        displayType: ConfirmationCodeDisplayType
    ) -> ConfirmationCodeController {
        let coordinator = ConfirmationCodeCoordinator()
        let authRepository = AuthRepository()
        let timerService = TimerService(timerInterval: resendCodeInterval, timerUpdateRate: .one)
        let viewModel = ConfirmationCodeViewModel(
            credentials: credentials,
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
