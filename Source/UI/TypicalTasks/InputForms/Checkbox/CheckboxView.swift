import SwiftUI

struct Checkbox: View {
    @Binding private var isSelected: Bool
    
    private let label: String?
    private let onTapAction: Closure.Void?
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(isSelected ? .accentColor : .gray)
            
            if let label = label {
                Text(label)
                    .font(.body)
                    .foregroundColor(.primary)
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                isSelected.toggle()
            }
            onTapAction?()
        }
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
