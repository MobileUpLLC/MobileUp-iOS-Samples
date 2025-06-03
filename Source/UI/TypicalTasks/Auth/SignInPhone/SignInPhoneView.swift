import SwiftUI
import FormView

struct SignInPhoneView: View {
    @ObservedObject var viewModel: SignInPhoneViewModel
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            SignInPhoneBodyView(
                isFocused: _isFocused,
                phoneNumber: $viewModel.phoneNumber,
                isPhoneNumberValid: $viewModel.isPhoneNumberValid,
                isError: viewModel.isError
            )
            Spacer()
        }
        .background(.white)
        .resignResponderOnTap()
        .navigationBarBackButtonHidden(true)
        .animation(.easeIn, value: isFocused)
        .overlay(alignment: .bottom) {
            SignInPhoneOverlayedButtonsView(
                isSaveButtonEnabled: viewModel.isPhoneNumberValid,
                isFocused: isFocused,
                isLoading: viewModel.isLoading,
                smsCoolDown: viewModel.smsCoolDown,
                onSaveButtonTapAction: {
                    isFocused = false
                    viewModel.handleSaveButtonTap()
                }
            )
            .padding(.horizontal, 28)
        }
    }
}

private struct SignInPhoneBodyView: View {
    private enum Constants {
        static let phoneNumberInputBlockId = "phoneNumberInputBlock"
    }
    
    @FocusState var isFocused: Bool
    @Binding var phoneNumber: String
    @Binding var isPhoneNumberValid: Bool
    
    let isError: Bool
    
    var body: some View {
        ScrollViewReader { scroll in
            VStack(alignment: .leading, spacing: 0) {
                Text(R.string.auth.signInPhoneTitle())
                    .font(UIFont.Heading.primary.asFont)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                
                FormView(validate: [.onFieldValueChanged]) { _ in
                    PhoneNumberInputBlock(
                        phoneNumber: $phoneNumber,
                        isValid: $isPhoneNumberValid
                    )
                    .focused($isFocused)
                    .id(Constants.phoneNumberInputBlockId)
                }.overlay(alignment: .bottomLeading) {
                    VStack {
                        if isError {
                            Text(R.string.common.errorStateTitle())
                                .foregroundColor(.red)
                        }
                    }
                    .offset(y: 12)
                }
                .animation(.linear, value: isError)
            }
            .padding(.horizontal, 28)
            .padding(.bottom, 150)
            .background(.white)
            .onChange(of: isFocused) { _ in
                scrollToItem(id: Constants.phoneNumberInputBlockId, scrollProxy: scroll)
            }
        }
    }
    
    private func scrollToItem(id: any Hashable, scrollProxy: ScrollViewProxy) {
        withAnimation {
            scrollProxy.scrollTo(id, anchor: .center)
        }
    }
}

private struct SignInPhoneOverlayedButtonsView: View {
    let isSaveButtonEnabled: Bool
    let isFocused: Bool
    let isLoading: Bool
    let smsCoolDown: String
    let onSaveButtonTapAction: Closure.Void
    
    var body: some View {
        VStack(spacing: 8) {
            Button(smsCoolDown.isEmpty ? R.string.common.buttonTitleSend() : .empty) {
                onSaveButtonTapAction()
            }
            .overlay {
                if smsCoolDown.isEmpty == false {
                    Text(smsCoolDown)
                        .frame(maxWidth: .infinity)
                        .font(UIFont.Button.small.asFont)
                        .foregroundColor(.gray)
                }
            }
        }
        .offset(y: isFocused ? 16 : 0)
    }
}

struct SignInPhoneView_Previews: PreviewProvider {
    static let viewModel = SignInPhoneViewModel(
        coordinator: SignInPhoneCoordinator(networkService: .init()),
        authRepository: AuthRepository(networkService: .init())
    )
    
    static var previews: some View {
        SignInPhoneView(viewModel: viewModel)
    }
}
