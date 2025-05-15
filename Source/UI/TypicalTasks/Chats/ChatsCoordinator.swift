final class ChatsCoordinator {
    weak var router: NavigationRouter?
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func showNativeChatModule() {
        let controller = NativeChatFactory.createNativeChatController(networkService: networkService)
        router?.push(controller: controller, isAnimated: true)
    }
    
    func showStarscreamChatModule() {
        let controller = StarscreamChatFactory.createStarscreamChatController(networkService: networkService)
        router?.push(controller: controller, isAnimated: true)
    }
}
