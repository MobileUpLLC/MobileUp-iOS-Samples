enum ListsFactory {
    static func createListsController() -> ListsController {
        let controller = ListsController(rootView: ListsView())
        
        return  controller
    }
}
