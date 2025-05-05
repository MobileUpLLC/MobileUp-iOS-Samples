final class EntranceCoordinator {
    weak var router: (RootRouter & NavigationRouter)?
    
    private var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func openTypicalTasks() {
        let controller = TypicalTasksFactory.createTypicalTasksController(networkService: networkService)
        
        router?.showApplicationRoot(controller: controller, animated: true)
    }
}
