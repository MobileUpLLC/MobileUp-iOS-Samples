import SwiftUI

extension View {
    func enableContentMargin(height: CGFloat) -> some View {
        if #available(iOS 17.0, *) {
            return self.contentMargins(
                .bottom,
                EdgeInsets(top: 0, leading: 0, bottom: height, trailing: 0),
                for: .scrollContent
            )
        } else {
            return self
        }
    }
}
