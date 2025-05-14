import SwiftUI
import FormView

struct TextFieldConfiguration {
    enum Mode {
        case singleline
        case multiline(lineLimit: Int, reservesSpace: Bool)
    }

    let title: LocalizedStringKey
    let value: Binding<String>
    let mode: Mode
    let failedRules: [ValidationRule]
}

struct UniversalFieldView: View {
    let config: TextFieldConfiguration

    var body: some View {
        VStack(alignment: .leading) {
            switch config.mode {
            case .singleline:
                TextField(config.title, text: config.value)
                    .disableAutocorrection(true)
                    .background(Color.white)
            case let .multiline(lineLimit, reservesSpace):
                TextField(config.title, text: config.value, axis: .vertical)
                    .lineLimit(lineLimit, reservesSpace: reservesSpace)
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
