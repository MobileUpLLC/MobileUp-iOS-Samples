final class PresentationCoordinator {
    weak var router: PresentationRouter?
    
    func showFullScreenController(isTransparent: Bool) {
        let controller = TransparentPresentationFactory.createTransparentPresentationController()
        controller.modalPresentationStyle = isTransparent ? .overFullScreen : .fullScreen
        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
}
