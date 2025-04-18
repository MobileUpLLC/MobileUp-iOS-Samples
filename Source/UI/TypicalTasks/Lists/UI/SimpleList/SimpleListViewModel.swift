import Foundation
import PagingList

final class SimpleListViewModel: ObservableObject {
    @Published var selectedSort: ListSortType = .default
    @Published var selectedFilter: ListFilterType = .default
    @Published var searchText: String = .empty
    @Published private(set) var state: ListState = .initial
    @Published private(set) var viewItems: [ListViewItem] = []
    
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
    
    func requestData() {
        Task {
            await requestDataAsync()
        }
    }
    
    func requestDataAsync(isRefresh: Bool = false) async {
        await MainActor.run {
            if isRefresh == false {
                state = .loading
            }
        }
        
        do {
            let response = try await repository.requestDataFromBackend(sort: selectedSort, filter: selectedFilter)
            await MainActor.run {
                handleResponse(response)
            }
        } catch {
            await MainActor.run {
                state = .error
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
