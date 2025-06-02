import SwiftUI

enum FieldHintViewType: Hashable {
    case error(String)
    case warning(String)
    case hintFulfilled(String)
    case hintNotFulfilled(String)
}

struct FieldHintsView: View {
    let hints: [FieldHintViewType]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(hints, id: \.self) { hint in
                switch hint {
                case .error(let hint):
                    HintView(text: hint, foregroundColor: .red)
                case .warning(let hint):
                    HintView(text: hint, foregroundColor: .gray)
                case .hintFulfilled(let hint):
                    HintView(
                        text: hint,
                        icon: Image(systemName: "checkmark"),
                        foregroundColor: .gray,
                        accentColor: .green
                    )
                case .hintNotFulfilled(let hint):
                    HintView(
                        text: hint,
                        icon: Image(systemName: "x.circle"),
                        foregroundColor: .gray,
                        accentColor: .red
                    )
                }
            }
        }
    }
}

private struct HintView: View {
    private let text: String
    private let icon: Image?
    private let foregroundColor: Color
    private let accentColor: Color?
    
    var body: some View {
        HStack(spacing: 4) {
            if let icon {
                icon
                    .foregroundStyle(getIconColor())
            }
            Text(text)
                .foregroundStyle(foregroundColor)
        }
    }
    
    init(text: String, icon: Image? = nil, foregroundColor: Color, accentColor: Color? = nil) {
        self.text = text
        self.icon = icon
        self.foregroundColor = foregroundColor
        self.accentColor = accentColor
    }
    
    private func getIconColor() -> Color {
        if let accentColor {
            return accentColor
        } else {
            return foregroundColor
        }
    }
}

#Preview {
    FieldHintsView(hints: [.hintFulfilled("test"), .hintNotFulfilled("test")])
}
