import SwiftUI

struct ToggleView: View {
    @Binding private var isSelected: Bool
    
    private let label: String?
    private let onTapAction: Closure.Void?
    
    var body: some View {
        Toggle(
            label ?? String.empty,
            isOn: Binding(
                get: { isSelected },
                set: { newValue in
                    isSelected = newValue
                    onTapAction?()
                }
            )
        )
        .toggleStyle(.switch)
        .tint(.accentColor)
    }
    
    init(isSelected: Binding<Bool>, label: String? = nil, onTapAction: Closure.Void? = nil) {
        self._isSelected = isSelected
        self.label = label
        self.onTapAction = onTapAction
    }
}
#Preview {
    Checkbox(isSelected: .constant(true))
}
