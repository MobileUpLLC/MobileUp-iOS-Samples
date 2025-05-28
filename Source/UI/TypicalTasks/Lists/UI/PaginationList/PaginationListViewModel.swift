import Foundation
import PagingList

final class PaginationListViewModel: ObservableObject {
    private enum Constants {
        static let itemsPerPage: Int = .ten
    }
    
    @Published var selectedSort: ListSortType = .default
    @Published var selectedFilter: ListFilterType = .default
    @Published var searchText: String = .empty
    @Published var pagingState: PagingListState = .pagingLoading
    @Published private(set) var viewItems: [ListViewItem] = []
    
    private let repository: ListRepository
    private var currentPage: Int = .zero
    
    init(repository: ListRepository) {
        self.repository = repository
    }
    
    func handleOnAppear() {
        requestData(isFirst: true)
    }
    
    func handleOnDisappear() {
        viewItems = []
        selectedSort = .default
        selectedFilter = .default
        searchText = .empty
    }
    
    func requestData(isFirst: Bool) {
        if isFirst {
            viewItems = []
            currentPage = .one
            pagingState = .fullscreenLoading
        } else {
            pagingState = .pagingLoading
        }
        
        Task {
            do {
                let page = isFirst ? currentPage : currentPage + .one
                let response = try await repository.requestPaginationDataFromBackend(
                    sort: selectedSort,
                    filter: selectedFilter,
                    page: page,
                    perPage: Constants.itemsPerPage
                )
                await MainActor.run {
                    currentPage = page
                    pagingState = response.total > page * Constants.itemsPerPage ? .items : .disabled
                    handleResponse(response.data)
                }
            } catch {
                await MainActor.run {
                    if isFirst {
                        pagingState = .fullscreenError(error)
                    } else {
                        pagingState = .pagingError(error)
                    }
                }
            }
        }
    }
    
    func refreshData() async {
        await MainActor.run {
            pagingState = .refresh
        }
        
        do {
            let response = try await repository.requestPaginationDataFromBackend(
                sort: selectedSort,
                filter: selectedFilter,
                page: .one,
                perPage: viewItems.count
            )
            await MainActor.run {
                pagingState = response.total > viewItems.count ? .items : .disabled
                handleRefresh(response.data)
            }
        } catch {
            await MainActor.run {
                pagingState = .fullscreenError(error)
            }
        }
    }
    
    private func handleResponse(_ response: [ListResponse]) {
        viewItems += response.map { ListViewItem(id: String($0.id)) }
    }
    
    private func handleRefresh(_ response: [ListResponse]) {
        viewItems = response.map { ListViewItem(id: String($0.id)) }
    }
}
