import SwiftUI
import FormView

enum InputFieldBlockType {
    case text
    case password
    case confirmPassword
}

struct InputFieldView: View {
    @Binding private var text: String
    @Binding private var outerRules: [OuterValidationRule]
    
    @State private var isFocusedState = false
    @State private var fieldWasInFocus = false
    
    private let header: String
    private let title: String
    private let placeholder: String?
    private let validationRules: [TextValidationRule]
    private let mask: String?
    private let type: InputFieldBlockType
    private let isRequired: Bool
    private let autocapitalization: TextInputAutocapitalization?
    private let textLimit: Int?
    
    private var isNotFilled: Bool { isFocusedState == false && text.isEmpty && fieldWasInFocus && isRequired }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if header.isEmpty == false {
                Text(header)
                    .foregroundStyle(.gray)
            }
            
            FormField(value: $text, rules: validationRules) { failedRules in
                VStack(alignment: .leading, spacing: 0) {
                    SingleInputField(
                        text: $text,
                        isFocusedState: $isFocusedState,
                        title: title,
                        placeholder: placeholder,
                        mask: mask,
                        isSecureEnabled: type == .password || type == .confirmPassword,
                        isRequired: isRequired,
                        isError: checkErrorState(with: failedRules),
                        autocapitalization: autocapitalization
                    )
                    FieldHintsView(hints: getHints(with: failedRules))
                        .frame(minHeight: 16)
                        .padding(.top, 6)
                        .padding(.bottom, 4)
                        .padding(.horizontal, 12)
                }
                .onChange(of: text) { _ in outerRules = [] }
                .onChange(of: isFocusedState) { isFocused in
                    if isFocused {
                        fieldWasInFocus = isFocused
                    }
                }
            }
        }
        .onChange(of: text) { newValue in
            if let textLimit, newValue.count > textLimit {
                text = String(newValue.prefix(textLimit))
                HapticFeedbackUtil.generate(.impact(.medium))
            }
        }
    }
    
    init(
        header: String = .empty,
        text: Binding<String>,
        outerRules: Binding<[OuterValidationRule]> = .constant([]),
        title: String,
        placeholder: String? = nil,
        validationRules: [TextValidationRule] = [],
        mask: String? = nil,
        type: InputFieldBlockType = .text,
        isRequired: Bool,
        autocapitalization: TextInputAutocapitalization? = nil,
        textLimit: Int? = nil
    ) {
        self.header = header
        self._text = text
        self._outerRules = outerRules
        self.title = title
        self.placeholder = placeholder
        self.validationRules = validationRules
        self.mask = mask
        self.type = type
        self.isRequired = isRequired
        self.autocapitalization = autocapitalization
        self.textLimit = textLimit
    }
    
    private func checkErrorState(with failedRules: [TextValidationRule]) -> Bool {
        let isValidationFailed = outerRules.isEmpty == false || failedRules.isEmpty == false
        return isValidationFailed && isFocusedState == false && text.isEmpty == false
    }
    
    private func getHints(with failedRules: [TextValidationRule]) -> [FieldHintViewType] {
        switch type {
        case .text, .confirmPassword:
            return getHintsForText(with: failedRules)
        case .password:
            return getHintsForPassword(with: failedRules)
        }
    }
    
    private func getHintsForText(with failedRules: [TextValidationRule]) -> [FieldHintViewType] {
        if isNotFilled {
            return [.error(R.string.common.ruleForFieldNotEmpty())]
        } else if let message = failedRules.first?.message {
            return [.error(message)]
        } else if let message = outerRules.first?.message {
            return [.error(message)]
        } else {
            return []
        }
    }
    
    private func getHintsForPassword(with failedRules: [TextValidationRule]) -> [FieldHintViewType] {
        if isNotFilled {
            return [.error(R.string.common.ruleForFieldNotEmpty())]
        } else if let message = outerRules.first?.message {
            return [.error(message)]
        } else if validationRules.isEmpty == false, fieldWasInFocus {
            return getPasswordFieldRuleHints(with: failedRules)
        } else {
            return []
        }
    }
    
    private func getPasswordFieldRuleHints(with failedRules: [TextValidationRule]) -> [FieldHintViewType] {
        if isFocusedState == false, failedRules.isEmpty {
            return []
        } else {
            return getMappedPasswordFieldRuleHints(with: failedRules)
        }
    }
    
    private func getMappedPasswordFieldRuleHints(with failedRules: [TextValidationRule]) -> [FieldHintViewType] {
        let hints: [FieldHintViewType] = validationRules.map { hint in
            if text.isEmpty || failedRules.contains(where: { $0.message == hint.message }) {
                return .hintNotFulfilled(hint.message)
            } else {
                return .hintFulfilled(hint.message)
            }
        }
        
        return hints
    }
}

struct SingleInputField: View {
    @Binding private var text: String
    @Binding private var isDisabled: Bool
    @Binding private var isFocusedState: Bool
    
    @State private var isSecure = true
    @FocusState private var isFocused: Bool
    
    private let isSecureEnabled: Bool
    private let placeholder: String?
    private let autocapitalization: TextInputAutocapitalization?
    private var isEmptyState: Bool { text.isEmpty && isFocused == false }
    
    var body: some View {
        HStack(spacing: 0) {
            InputField(
                text: $text,
                placeholder: placeholder ?? .empty,
                isSecure: isSecureEnabled ? isSecure : false
            )
            .textInputAutocapitalization(autocapitalization)
            .frame(height: 24)
            .lineLimit(1)
            .textInputAutocapitalization(.never)
            .focused($isFocused)
            .opacity(isEmptyState ? 0 : 1)
            .font(UIFont.Body.primary.asFont)
            .disabled(isDisabled)
            if isFocused {
                Spacer(minLength: 8)
                Image(systemName: "x.circle")
                    .opacity(text.isEmpty ? 0 : 1)
                    .onTapGesture { withAnimation { text = .empty } }
            }
        }
    }
    
    init(
        text: Binding<String>,
        isDisabled: Binding<Bool> = .constant(false),
        isFocusedState: Binding<Bool> = .constant(false),
        title: String,
        placeholder: String? = nil,
        mask: String? = nil,
        isSecureEnabled: Bool,
        isRequired: Bool,
        isError: Bool,
        autocapitalization: TextInputAutocapitalization? = nil
    ) {
        self._text = text
        self._isDisabled = isDisabled
        self._isFocusedState = isFocusedState
        self.placeholder = placeholder
        self.isSecureEnabled = isSecureEnabled
        self.autocapitalization = autocapitalization
    }
}

private struct InputField: View {
    @Binding var text: String
    
    let placeholder: String
    let isSecure: Bool
    
    var body: some View {
        if isSecure {
            SecureField(placeholder, text: $text)
                .textContentType(.newPassword)
                .textInputAutocapitalization(.never)
        } else {
            TextField(placeholder, text: $text)
        }
    }
}

#Preview {
    VStack {
        InputFieldView(
            text: .constant("text"),
            title: "This is a title",
            validationRules: [TextValidationRule.maxLength(count: 8, message: "maxLength 8")],
            mask: nil,
            type: .password,
            isRequired: true
        )
        
        InputFieldView(
            text: .constant(.empty),
            title: "This is a title",
            mask: nil,
            type: .text,
            isRequired: false
        )
    }
    .padding(.horizontal)
    .background(.white)
}
