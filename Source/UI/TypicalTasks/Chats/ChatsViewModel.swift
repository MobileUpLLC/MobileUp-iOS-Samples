import Foundation

final class ChatsViewModel: ObservableObject {
    var chatViewItems: [ChatsViewItem] = []
    
    private let coordinator: ChatsCoordinator
    
    init(coordinator: ChatsCoordinator) {
        self.coordinator = coordinator
        
        chatViewItems = getChatViewItems()
    }
    
    func onItemTap(item: ChatsViewItem) {
        item.action()
    }
    
    private func getChatViewItems() -> [ChatsViewItem] {
        return [
            .init(
                title: R.string.typicalTasks.typicalTasksNativeChats(),
                action: { [weak self] in self?.coordinator.showNativeChatModule() }
            ),
            .init(
                title: R.string.typicalTasks.typicalTasksStarscreamChats(),
                action: { [weak self] in self?.coordinator.showStarscreamChatModule() }
            )
        ]
    }
}
