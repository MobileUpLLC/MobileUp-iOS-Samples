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
    private let config: TextFieldConfiguration
    private let isSecureField: Bool
    
    @FocusState private var isFocused: Bool
    @State private var isSecure = false
    
    var body: some View {
        VStack(alignment: .leading) {
            switch config.mode {
            case .singleline:
                fieldView
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
        if case let .singleline(isSecure) = config.mode {
            self._isSecure = State(initialValue: isSecure)
            isSecureField = isSecure
        } else {
            isSecureField = false
        }
    }
    
    private var fieldView: some View {
        HStack(spacing: .five) {
            Group {
                if isSecure {
                    SecureField(config.title, text: config.value)
                        .textContentType(.newPassword)
                } else {
                    TextField(config.title, text: config.value)
                }
            }
            .textFieldStyle(.plain)
            .focused($isFocused)
            .disableAutocorrection(true)
            if isSecureField {
                eyeImage
            }
        }
        .frame(height: 28)
        .background(.white)
        .defaultStroke(cornerRadius: 5, lineWidth: 1, color: .gray)
    }
    
    private var eyeImage: some View {
        Image(systemName: isSecure ? "eye" : "eye.slash")
            .onTapGesture {
                isSecure.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isFocused = true
                }
            }
    }
}
