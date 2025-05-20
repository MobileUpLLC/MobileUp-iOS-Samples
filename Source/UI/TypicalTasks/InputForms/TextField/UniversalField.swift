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
    let config: TextFieldConfiguration
    
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            switch config.mode {
            case .singleline(let isSecure):
                Group {
                    if isSecure {
                        SecureField(config.title, text: config.value)
                            .textContentType(.newPassword)
                    } else {
                        TextField(config.title, text: config.value)
                    }
                }
                .focused($isFocused)
                .disableAutocorrection(true)
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
}
