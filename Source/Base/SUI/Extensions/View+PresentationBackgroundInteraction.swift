import SwiftUI

extension View {
    func enablePresentationBackgroundInteraction(upThrough detent: PresentationDetent) -> some View {
        if #available(iOS 16.4, *) {
            return self.presentationBackgroundInteraction(.enabled(upThrough: detent))
        } else {
            return self
        }
    }
}
