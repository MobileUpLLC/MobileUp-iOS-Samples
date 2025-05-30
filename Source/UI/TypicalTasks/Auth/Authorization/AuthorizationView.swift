import SwiftUI
import FormView

struct AuthorizationView: View {
    @ObservedObject var viewModel: AuthorizationViewModel
    
    @FocusState private var isFocused: Bool
    private var isSignButtonDisabled: Bool { getIsSignButtonDisabled() }
    
    var body: some View {
        FormView(validate: .onFieldValueChanged) { proxy in
            ScrollWithToolBarView {
                InputContentView(viewModel: viewModel, isFocused: _isFocused)
                    .padding(.horizontal, 20)
                    .background(.white)
            } bottomToolBar: { isContentOverToolBar in
                Button(R.string.auth.authorizationSignButtonTitle()) {
                    if proxy.validate() {
                        isFocused = false
                        viewModel.handleSignButtonTapped()
                    } else {
                        viewModel.handleFailedValid()
                    }
                }
                .disabled(isSignButtonDisabled)
            }
        }
        .background(.white)
        .onTapGesture {
            isFocused = false
        }
    }
    
    private func getIsSignButtonDisabled() -> Bool {
        return viewModel.isLoading
        || viewModel.email.isEmpty
        || viewModel.password.isEmpty
    }
}

private struct InputContentView: View {
    @ObservedObject var viewModel: AuthorizationViewModel
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            InputFieldView(
                header: R.string.auth.authorizationInputEmailTitle(),
                text: $viewModel.email,
                outerRules: $viewModel.outerEmailRules,
                title: R.string.auth.registrationEmailFieldTitle(),
                validationRules: [.email(message: R.string.common.ruleEmail())],
                type: .text,
                isRequired: true
            )
            .padding(.top, 26)
            .keyboardType(.emailAddress)
            .disableAutocorrection(true)
            .focused($isFocused)
            
            InputFieldView(
                header: R.string.auth.authorizationInputPasswordTitle(),
                text: $viewModel.password,
                outerRules: $viewModel.outerPasswordRules,
                title: R.string.auth.registrationPasswordFieldTitle(),
                validationRules: [],
                type: .password,
                isRequired: true,
                textLimit: 32
            )
            .padding(.top, 26)
            .focused($isFocused)
            ForgotPasswordButton {
                viewModel.onForgotPasswordButtonTapped()
            }
        }
    }
}

private struct ForgotPasswordButton: View {
    let action: Closure.Void
    
    var body: some View {
        HStack {
            Button(R.string.auth.authorizationForgotPasswordTitle()) {
                action()
            }
            // Решает проблему скрытия заголовка на малых экранах, например iPhone SE
            .padding(.trailing, -1)
            Spacer()
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    AuthorizationView(
        viewModel: AuthorizationViewModel(
            coordinator: AuthorizationCoordinator(networkService: .init()),
            authRepository: AuthRepository(networkService: .init())
        )
    )
}
