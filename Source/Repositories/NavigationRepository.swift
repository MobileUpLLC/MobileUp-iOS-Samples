final class NavigationRepository {
    var onTextSubmit: Closure.String? {
        didSet { textSubmitEventBus = EventBus(subscribe: onTextSubmit) }
    }
    
    private var textSubmitEventBus = EventBus<String>()
    
    func sendTextSubmitEvent(text: String) {
        textSubmitEventBus.send(event: text)
    }
}
