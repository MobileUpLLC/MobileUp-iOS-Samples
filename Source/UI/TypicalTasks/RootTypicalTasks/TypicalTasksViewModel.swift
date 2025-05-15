import Foundation

final class TypicalTasksViewModel: ViewModel {
    private let coordinator: TypicalTasksCoordinator
    
    var typicalTasks: [TypicalTasksViewItem] = []
    
    init(coordinator: TypicalTasksCoordinator) {
        self.coordinator = coordinator
        
        super.init()
        
        typicalTasks = getTypicalTasks()
    }
    
    func onItemTap(item: TypicalTasksViewItem) {
        item.action()
    }
    
    private func showAuthorizationModule() {
        coordinator.showAuthorizationModule()
    }
    
    private func getTypicalTasks() -> [TypicalTasksViewItem] {
        return [
            .init(
                title: R.string.typicalTasks.typicalTasksAuthorization(),
                action: { [weak self] in
                    self?.showAuthorizationModule()
                }
            ),
            .init(
                title: R.string.typicalTasks.typicalTasksLists(),
                action: { [weak self] in self?.coordinator.showLists() }
            ),
            .init(
                title: R.string.typicalTasks.complexUiElements(),
                action: { [weak self] in self?.coordinator.showComplexUIComponents() }
            ),
            .init(
                title: R.string.typicalTasks.typicalTasksChats(),
                action: { [weak self] in self?.coordinator.showChatsModule() }
            )
        ]
    }
}
