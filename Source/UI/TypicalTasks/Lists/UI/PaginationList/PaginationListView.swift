import SwiftUI
import PagingList

struct PaginationListView: View {
    @ObservedObject var viewModel: PaginationListViewModel
    
    var body: some View {
        VStack {
            SortFilterSearchView(
                selectedSort: $viewModel.selectedSort,
                selectedFilter: $viewModel.selectedFilter,
                searchText: $viewModel.searchText,
                performRequest: { viewModel.requestData(isFirst: true) }
            )
            .padding(.horizontal)
            PagingList(
                state: $viewModel.pagingState,
                items: viewModel.viewItems) { item in
                    Text(item.id)
                } fullscreenEmptyView: {
                    EmptyContentView()
                } fullscreenLoadingView: {
                    LoadingView()
                } fullscreenErrorView: { _ in
                    ListErrorView()
                } pagingDisabledView: {
                    Text("Paging disabled")
                } pagingLoadingView: {
                    LoadingView()
                } pagingErrorView: { error in
                    Text("Paging error: \(error)")
                } onPageRequest: { isFirst in
                    viewModel.requestData(isFirst: isFirst)
                } onRefreshRequest: {
                    await viewModel.refreshData()
            }
        }
        .onDebouncedTextChange(text: viewModel.$searchText, delay: 0.3) {
            viewModel.requestData(isFirst: true)
        }
        .onAppear(perform: viewModel.handleOnAppear)
        .onDisappear(perform: viewModel.handleOnDisappear)
    }
}

#Preview {
    PaginationListView(viewModel: PaginationListViewModel(repository: ListRepository()))
}
