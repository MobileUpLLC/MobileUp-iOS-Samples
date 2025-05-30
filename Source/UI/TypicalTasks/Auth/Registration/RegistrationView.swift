import SwiftUI
import FormView

struct RegistrationView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    
    @FocusState private var isFocused: Bool
    
    private var isNextButtonDisabled: Bool {
        return viewModel.isLoading
        || viewModel.email.isEmpty
        || viewModel.password.isEmpty
        || viewModel.confirmPassword.isEmpty
    }

    var body: some View {
        VStack {
            FormView(validate: .onFieldValueChanged) { proxy in
                ScrollWithToolBarView {
                    InputContentView(viewModel: viewModel, isFocused: _isFocused)
                        .padding(.horizontal, 20)
                } bottomToolBar: { isContentOverToolBar in
                    BottomToolBarButton(
                        title: R.string.auth.registrationNextButtonTitle(),
                        isShowDivider: isContentOverToolBar,
                        isLoading: $viewModel.isLoading,
                        action: {
                            if proxy.validate() {
                                isFocused = false
                                viewModel.handleNextButtonTapped()
                            } else {
                                viewModel.handleFailedValid()
                            }
                        }
                    )
                    .disabled(isNextButtonDisabled)
                    .background(.white)
                }
            }
        }
        .background(.white)
        .onTapGesture {
            isFocused = false
        }
    }
}

private struct InputContentView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    @FocusState var isFocused: Bool
    
    var body: some View {
        ScrollViewReader { _ in
            VStack(alignment: .leading, spacing: 4) {
                InputFieldView(
                    header: R.string.auth.registrationInputEmailTitle(),
                    text: $viewModel.email,
                    outerRules: $viewModel.outerEmailRules,
                    title: R.string.auth.registrationEmailFieldTitle(),
                    validationRules: [.email(message: R.string.common.ruleEmail())],
                    type: .text,
                    isRequired: true
                )
                .padding(.top, 28)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .focused($isFocused)
                Spacer()
                    .frame(height: 12)
                InputFieldView(
                    header: R.string.auth.registrationInputPasswordTitle(),
                    text: $viewModel.password,
                    outerRules: $viewModel.outerPasswordRules,
                    title: R.string.auth.registrationPasswordFieldTitle(),
                    validationRules: .password,
                    type: .password,
                    isRequired: true
                )
                .padding(.top, 8)
                .focused($isFocused)
                InputFieldView(
                    text: $viewModel.confirmPassword,
                    outerRules: $viewModel.outerPasswordRules,
                    title: R.string.auth.registrationConfirmPasswordFieldTitle(),
                    validationRules: [.confirmPassword(value: viewModel.password)],
                    type: .confirmPassword,
                    isRequired: true
                )
                .padding(.top, 4)
                .focused($isFocused)
                AgreementView(
                    termsLink: viewModel.termsLink,
                    privacyLink: viewModel.privacyLink,
                    onLinkTapAction: viewModel.handleLinkTap
                )
                .padding(.top, 22)
            }
        }
    }
}

private struct AgreementView: View {
    let termsLink: String
    let privacyLink: String
    let onLinkTapAction: Closure.String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(R.string.auth.registrationAgreementTitle())
                .foregroundStyle(.gray)
            TermsView(
                termsLink: termsLink,
                privacyLink: privacyLink,
                onLinkTapAction: onLinkTapAction
            )
            .padding(.top, 18)
        }
    }
}

private struct TermsView: View {
    let termsLink: String
    let privacyLink: String
    let onLinkTapAction: Closure.String
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Group {
                Text(R.string.auth.registrationAgreementIntro())
                + Text(markdownToAttributed(string: R.string.auth.registrationPrivacyConditions(privacyLink)))
                    .underline()
                + Text(R.string.auth.registrationAgreementSeparator())
                + Text(markdownToAttributed(string: R.string.auth.registrationTermsConditions(termsLink)))
                    .underline()
            }
            .foregroundStyle(.blue)
            .tint(.blue)
            .fixedSize(horizontal: false, vertical: true)
            .environment(\.openURL, OpenURLAction { url in
                onLinkTapAction(url.absoluteString)
                return .handled
            })
            Spacer()
        }
        .frame(height: 34)
    }
    
    private func markdownToAttributed(string: String) -> AttributedString {
        guard let markdownToAttributed = try? AttributedString(markdown: string) else {
            return AttributedString(string)
        }
        
        return markdownToAttributed
    }
}

#Preview {
    RegistrationView(
        viewModel: RegistrationViewModel(
            coordinator: RegistrationCoordinator(networkService: .init()),
            authRepository: AuthRepository(networkService: .init())
        )
    )
}
