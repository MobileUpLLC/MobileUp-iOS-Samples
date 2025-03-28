import UIKit

final class WebPageCoordinator {
    weak var router: PresentationRouter?
    
    func close() {
        router?.dismiss(isAnimated: true, completion: nil)
    }
}
