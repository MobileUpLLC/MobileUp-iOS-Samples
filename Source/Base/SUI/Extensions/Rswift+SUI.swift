import RswiftResources
import SwiftUI

extension RswiftResources.ColorResource {
    var color: Color { Color(name) }
    var asUIColor: UIColor { UIColor(named: name) ?? .black }
}

extension RswiftResources.ImageResource {
    var image: Image { Image(name) }
    var asUIImage: UIImage { UIImage(named: name) ?? UIImage() }
}
