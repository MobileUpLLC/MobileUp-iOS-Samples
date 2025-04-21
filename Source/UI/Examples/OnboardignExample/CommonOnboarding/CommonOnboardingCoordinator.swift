final class CommonOnboardingCoordinator {
    weak var router: PresentationRouter?
    
    func dismiss() {
        router?.dismiss(isAnimated: true, completion: nil)
    }
}
