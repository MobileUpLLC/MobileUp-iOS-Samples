import SwiftUI

struct GenericButton: View {
    private let styleType: GenericButtonStyleType
    private let contentType: GenericButtonContentType
    private let style: GenericButtonStyle
    private let isStretching: Bool
    private let isLoading: Bool
    private let isEnabled: Bool
    private let action: Closure.Void

    var body: some View {
        Button {
            action()
        } label: {
            GenericButtonContentView(type: contentType, isLoading: isLoading, isEnabled: isEnabled)
                .padding(styleType.contentHorizontalPadding)
                .frame(width: styleType.width, height: styleType.height)
                .frame(maxWidth: isStretching ? .infinity : styleType.width)
        }
        .buttonStyle(style)
        .disabled(isEnabled == false)
        .animation(.default, value: isEnabled)
    }
    
    init(
        styleType: GenericButtonStyleType,
        contentType: GenericButtonContentType,
        style: GenericButtonStyle,
        isStretching: Bool = true,
        isLoading: Bool = false,
        isEnabled: Bool = true,
        action: @escaping Closure.Void
    ) {
        self.styleType = styleType
        self.contentType = contentType
        self.style = style
        self.isStretching = isStretching
        self.isLoading = isLoading
        self.isEnabled = isEnabled
        self.action = action
    }
}
