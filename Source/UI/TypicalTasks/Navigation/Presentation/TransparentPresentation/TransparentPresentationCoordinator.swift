final class TransparentPresentationCoordinator {
    weak var router: PresentationRouter?
    
    func dismiss() {
        router?.dismiss(isAnimated: true, completion: nil)
    }
}
