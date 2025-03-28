import SwiftUI

// Добавить при необходимости типы контента для кнопок
enum GenericButtonContentType {
    case centeredText(String)
    case centeredImage(Image)
}

struct GenericButtonContentView: View {
    let type: GenericButtonContentType
    let isLoading: Bool
    let isEnabled: Bool

    var body: some View {
        switch type {
        case let .centeredText(text):
            CenteredTextContent(text: text, isLoading: isLoading)
        case let .centeredImage(icon):
            CenteredImageContent(icon: icon, isLoading: isLoading)
        }
    }
}

private struct CenteredImageContent: View {
    let icon: Image
    let isLoading: Bool
    
    var body: some View {
        icon
            .loadable(isLoading: isLoading)
    }
}

private struct CenteredTextContent: View {
    let text: String
    let isLoading: Bool
    
    var body: some View {
        Text(text)
            .loadable(isLoading: isLoading)
    }
}
