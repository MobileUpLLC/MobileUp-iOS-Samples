import SwiftUI

// добавит placeholder ко view, например для textField
// Внимательно настраиваем размеры placeholder что бы он соответствовал view
extension View {
    func placeholder(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        placeholder: String,
        font: Font,
        foregroundColor: Color,
        verticalPadding: CGFloat,
        horizontalPadding: CGFloat
    ) -> some View {
        ZStack(alignment: alignment) {
            Text(placeholder)
                .font(font)
                .foregroundColor(foregroundColor)
                .padding(.vertical, verticalPadding)
                .padding(.horizontal, horizontalPadding)
                .opacity(shouldShow ? 1 : 0)
                .disabled(true)
            
            self
        }
    }
}
