import SwiftUI
import Kingfisher

struct ImageView: View {
    let imageLink: String?
    let placeholder: Image?
    let onSuccessAction: Closure.Void?
    let onFailureAction: Closure.Void?
    
    var body: some View {
        KFImage(URL(string: imageLink ?? .empty))
            .placeholder {
                if let placeholder {
                    placeholder
                        .resizable()
                } else {
                    ProgressView()
                }
            }
            .resizable()
            .fade(duration: 0.2)
            .onSuccess { _ in
                onSuccessAction?()
            }
            .onFailure { _ in
                onFailureAction?()
            }
    }
    
    init(
        imageLink: String?,
        placeholder: Image? = nil,
        onSuccessAction: Closure.Void? = nil,
        onFailureAction: Closure.Void? = nil
    ) {
        self.imageLink = imageLink
        self.placeholder = placeholder
        self.onSuccessAction = onSuccessAction
        self.onFailureAction = onFailureAction
    }
}
