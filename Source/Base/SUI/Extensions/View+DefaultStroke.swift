import SwiftUI

// добавляет настраиваемый border ко вью
extension View {
    func defaultStroke(
        cornerRadius: CGFloat = 30,
        lineWidth: CGFloat = 1,
        color: Color,
        isHidden: Bool = false
    ) -> some View {
        return self
            .overlay {
                if isHidden == false {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(color, lineWidth: lineWidth)
                }
            }
    }
}
