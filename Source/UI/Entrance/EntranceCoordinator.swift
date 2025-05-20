final class EntranceCoordinator {
    weak var router: RootRouter?
    
    private var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}
