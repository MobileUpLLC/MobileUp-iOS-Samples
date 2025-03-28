import SwiftUI

struct GenericButtonStyle: ButtonStyle {
    let backgroundColorSet: GenericButtonColorsSet
    let foregroundColorSet: GenericButtonColorsSet
    let strokeColorSet: GenericButtonColorsSet?
    let isRounded: Bool
    let cornerRadius: CGFloat
    let font: Font
    let isLoading: Bool
    
    @SwiftUI.Environment(\.isEnabled) private var isEnabled
    
    init(
        backgroundColorSet: GenericButtonColorsSet,
        foregroundColorSet: GenericButtonColorsSet,
        strokeColorSet: GenericButtonColorsSet? = nil,
        isRounded: Bool = false,
        cornerRadius: CGFloat = .zero,
        font: Font,
        isLoading: Bool
    ) {
        self.backgroundColorSet = backgroundColorSet
        self.foregroundColorSet = foregroundColorSet
        self.strokeColorSet = strokeColorSet
        self.isRounded = isRounded
        self.cornerRadius = cornerRadius
        self.font = font
        self.isLoading = isLoading
    }
        
    func makeBody(configuration: Configuration) -> some View {
        let foregroundColor = foregroundColorSet.getColor(
            isLoading: isLoading,
            isPressed: configuration.isPressed,
            isActive: isEnabled
        )

        let backgroundColor = backgroundColorSet.getColor(
            isLoading: isLoading,
            isPressed: configuration.isPressed,
            isActive: isEnabled
        )
        
        let strokeColor = strokeColorSet?.getColor(
            isLoading: isLoading,
            isPressed: configuration.isPressed,
            isActive: isEnabled
        )
        
        configuration
            .label
            .lineLimit(1)
            .foregroundColor(foregroundColor)
            .tint(foregroundColor)
            .background(backgroundColor)
            .font(font)
            .clipShape(isRounded ? AnyShape(Circle()) : AnyShape(RoundedRectangle(cornerRadius: cornerRadius)))
            .contentShape(isRounded ? AnyShape(Circle()) : AnyShape(RoundedRectangle(cornerRadius: cornerRadius)))
            .circleStrokeIfNeeded(color: strokeColor)
            .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
            .animation(configuration.isPressed ? .easeIn(duration: 0.1) : .default, value: configuration.isPressed)
    }
    
    // Добавить стили под кнопки в проекте.
    static func getPrimaryButtonStyle(type: GenericButtonStyleType, isLoading: Bool) -> Self {
        // Заполнить параметры стиля
        GenericButtonStyle(
            backgroundColorSet: GenericButtonColorsSet(
                active: .white,
                pressed: .white,
                disabled: .white,
                loading: .white
            ),
            foregroundColorSet: GenericButtonColorsSet(
                active: .white,
                pressed: .white,
                disabled: .white,
                loading: .white
            ),
            font: .title,
            isLoading: isLoading
        )
    }
    
    static func getSecondaryButtonStyle(type: GenericButtonStyleType, isLoading: Bool) -> Self {
        // Заполнить параметры стиля
        GenericButtonStyle(
            backgroundColorSet: GenericButtonColorsSet(
                active: .white,
                pressed: .white,
                disabled: .white,
                loading: .white
            ),
            foregroundColorSet: GenericButtonColorsSet(
                active: .white,
                pressed: .white,
                disabled: .white,
                loading: .white
            ),
            font: .title,
            isLoading: isLoading
        )
    }
}
