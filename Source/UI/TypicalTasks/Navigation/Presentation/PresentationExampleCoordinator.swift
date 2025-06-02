final class PresentationExampleCoordinator {
    weak var router: PresentationRouter?
    
    func showFullScreenController(isTransparent: Bool) {
        let controller = TransparentPresentationExampleFactory.createTransparentPresentationExampleController()
        controller.modalPresentationStyle = isTransparent ? .overFullScreen : .fullScreen
        
        router?.present(controller: controller, isAnimated: true, completion: nil)
    }
}
