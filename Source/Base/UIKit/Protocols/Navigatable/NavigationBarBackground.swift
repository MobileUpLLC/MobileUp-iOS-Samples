import UIKit

extension NavigationBarBackground {
    struct ImageToGradientViewItem {
        let loadingImage: UIImage?
        let loadedImage: UIImage?
        let gradient: [UIColor]
        
        init(loadingImage: UIImage? = nil, loadedImage: UIImage? = nil, gradient: [UIColor]) {
            self.loadingImage = loadingImage
            self.loadedImage = loadedImage
            self.gradient = gradient
        }
    }
}

/// - Attention: Градиент устанавливается с левого нижнего к правому верхнему углу фона.
enum NavigationBarBackground {
    case color(UIColor)
    case gradient([UIColor])
    case image(UIImage)
    case imageToGradient(ImageToGradientViewItem)
}
