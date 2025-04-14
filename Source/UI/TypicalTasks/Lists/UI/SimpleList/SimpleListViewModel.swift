import Foundation
import PagingList

final class SimpleListViewModel: ObservableObject {
    @Published var state: ListState = .initial
    @Published var viewItems: [ListViewItem] = []
    @Published var selectedSort: ListSortType = .default
    @Published var selectedFilter: ListFilterType = .default
    @Published var searchText: String = .empty
    
    private let repository: ListRepository
    
    init(repository: ListRepository) {
        self.repository = repository
    }
    
    func handleOnAppear() {
        requestData()
    }
    
    func handleOnDisappear() {
        viewItems = []
        selectedSort = .default
        selectedFilter = .default
        searchText = .empty
    }
    
    func requestData(isRefresh: Bool = false) {
        if isRefresh == false {
            state = .loading
        }
        
        Task(priority: .background) {
            do {
                let response = try await repository.requestDataFromBackend(sort: selectedSort, filter: selectedFilter)
                
                Task { @MainActor in
                    handleResponse(response)
                }
            } catch {
                Task { @MainActor in
                    state = .error
                }
            }
        }
    }
    
    private func handleResponse(_ response: [ListResponse]) {
        if response.isEmpty {
            state = .empty
        } else {
            viewItems = response.map { ListViewItem(id: String($0.id)) }
            state = .content
        }
    }
}
