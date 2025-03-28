import UIKit

extension CAGradientLayer {
    func setupGradient(with colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint ) -> CAGradientLayer {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.colors = colors
        
        return self
    }
}
