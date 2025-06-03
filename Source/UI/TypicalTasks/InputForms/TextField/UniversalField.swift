import SwiftUI
import FormView

struct TextFieldConfiguration {
    enum Mode {
        case singleline(isSecure: Bool)
        case multiline(lineLimit: Int, isDynamic: Bool)
    }
    
    let title: LocalizedStringKey
    let value: Binding<String>
    let mode: Mode
    let failedRules: [ValidationRule]
}

struct UniversalFieldView: View {
    @FocusState private var isFocused: Bool
    
    private let config: TextFieldConfiguration
    
    var body: some View {
        VStack(alignment: .leading) {
            switch config.mode {
            case .singleline(let isSecure):
                FieldView(
                    text: config.value,
                    isFocused: _isFocused,
                    title: config.title,
                    isSecureField: isSecure
                )
            case let .multiline(lineLimit, isDynamic):
                TextField(config.title, text: config.value, axis: .vertical)
                    .lineLimit(lineLimit, reservesSpace: isDynamic == false)
                    .onSubmit { config.value.wrappedValue += "\n" }
                    .disableAutocorrection(true)
                    .background(Color.white)
                    .scrollContentBackground(.hidden)
            }
            if let errorMessage = config.failedRules.first?.message, errorMessage.isEmpty == false {
                Text(errorMessage)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.red)
            }
        }
    }
    
    init(config: TextFieldConfiguration) {
        self.config = config
    }
}

private struct FieldView: View {
    @Binding private var text: String
    @State private var isSecure: Bool
    @FocusState var isFocused: Bool
    
    private let title: LocalizedStringKey
    private let isSecureField: Bool
    
    var body: some View {
        HStack(spacing: .five) {
            Group {
                if isSecure {
                    SecureField(title, text: $text)
                        .textContentType(.newPassword)
                } else {
                    TextField(title, text: $text)
                }
            }
            .textFieldStyle(.plain)
            .focused($isFocused)
            .disableAutocorrection(true)
            if isSecureField {
                Image(systemName: isSecure ? "eye" : "eye.slash")
                    .onTapGesture {
                        isSecure.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isFocused = true
                        }
                    }
            }
        }
        .frame(height: 28)
        .background(.white)
        .defaultStroke(cornerRadius: 5, lineWidth: 1, color: .gray)
    }
    
    init(text: Binding<String>, isFocused: FocusState<Bool>, title: LocalizedStringKey, isSecureField: Bool) {
        self._text = text
        self._isFocused = isFocused
        self.title = title
        self.isSecureField = isSecureField
        self.isSecure = isSecureField
    }
}
