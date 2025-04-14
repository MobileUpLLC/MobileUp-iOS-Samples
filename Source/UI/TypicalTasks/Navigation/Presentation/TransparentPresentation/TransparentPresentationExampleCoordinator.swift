// swiftlint:disable:next type_name
final class TransparentPresentationExampleCoordinator {
    weak var router: PresentationRouter?
    
    func dismiss() {
        router?.dismiss(isAnimated: true, completion: nil)
    }
}
