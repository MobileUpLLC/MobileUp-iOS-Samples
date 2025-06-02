import SwiftUI

extension ConfirmationCodeView {
    private enum Constants {
        static let durationAnimation = 0.2
    }
}

struct ConfirmationCodeView: View {
    @ObservedObject var viewModel: ConfirmationCodeViewModel
    
    @State private var shake = false

    var body: some View {
        VStack(spacing: 0) {
            OTPInputView(
                text: $viewModel.code,
                state: $viewModel.codeOTPBlockState,
                onTextChange: viewModel.sendCodeIfNeeded
            )
            ResendSMSView(
                confirmCodeViewState: viewModel.state,
                sendCodeCooldown: viewModel.sendCodeCooldown,
                onResendButtonTapAction: viewModel.handleResendButtonTap
            )
        }
        .background(.white)
        .onChange(of: viewModel.codeOTPBlockState) { state in
            if state == .error {
                shake = true
            }
        }
        .onChange(of: shake) { newValue in
            if newValue {
                resetOTPBlockPosition()
            }
        }
    }
    
    private func resetOTPBlockPosition() {
        onMainAfter(deadline: .now() + Constants.durationAnimation) {
            shake = false
        }
    }
}

private struct ResendSMSView: View {
    let confirmCodeViewState: ConfirmCodeViewState
    let sendCodeCooldown: String
    let onResendButtonTapAction: Closure.Void
    
    var body: some View {
        if sendCodeCooldown.isEmpty, confirmCodeViewState != .loadingOnResend {
            Text(R.string.auth.confirmationCodeResendButtonTitle())
                .foregroundStyle(.blue)
                .onTapGesture(perform: onResendButtonTapAction)
        } else {
            HStack(spacing: 8) {
                Text(confirmCodeViewState == .loadingOnResend
                     ? R.string.auth.confirmationCodeResendButtonTitle()
                     : R.string.auth.confirmationCodeAgainResendButtonTitle(sendCodeCooldown))
                if confirmCodeViewState == .loadingOnResend {
                    LoaderView(
                        progress: 0.75,
                        startGradientColor: .gray,
                        endGradientColor: .gray,
                        lineWidth: 2
                    )
                    .frame(width: 20, height: 20)
                }
            }
            .foregroundStyle(.gray)
        }
    }
}

#Preview {
    ConfirmationCodeView(
        viewModel: ConfirmationCodeViewModel(
            credentials: "test@gmail.com",
            displayType: .present,
            coordinator: ConfirmationCodeCoordinator(networkService: .init()),
            authRepository: AuthRepository(networkService: .init()),
            timerService: TimerService(timerInterval: 60, timerUpdateRate: .one)
        )
    )
}
