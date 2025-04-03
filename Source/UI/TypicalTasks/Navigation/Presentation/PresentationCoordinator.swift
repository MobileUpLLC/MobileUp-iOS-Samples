final class PresentationCoordinator {
    weak var router: PresentationRouter?
    
    func showFullScreenController() {
        let controller = TransparentPresentationFactory.createTransparentPresentationController()
        controller.modalPresentationStyle = .fullScreen
        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
    
    func showTransparentFullScreenController() {
        let controller = TransparentPresentationFactory.createTransparentPresentationController()
        controller.modalPresentationStyle = .overFullScreen
        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
}
