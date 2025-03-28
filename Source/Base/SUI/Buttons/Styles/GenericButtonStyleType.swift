import SwiftUI

enum GenericButtonStyleType {
    case primary
    case secondary
    
    // TODO: Заполнить высоту
    var height: CGFloat {
        return 0
    }
    
    // TODO: Заполнить ширину
    var width: CGFloat? {
        return 0
    }
    
    // TODO: Заполнить горизонтальный отступ от контента
    var contentHorizontalPadding: CGFloat {
        return 0
    }
    
    // TODO: Заполнить корнер радиус
    var cornerRadius: CGFloat {
        return 0
    }

    // TODO: Заполнить фонт
    var font: Font {
        return .subheadline
    }
    
    // TODO: Заполнить цвет обводки
    var strokeColor: Color {
        return .clear
    }
}
