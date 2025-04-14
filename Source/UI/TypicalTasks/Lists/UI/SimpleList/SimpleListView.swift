import SwiftUI

struct SimpleListView: View {
    @ObservedObject var viewModel: SimpleListViewModel
        
    var body: some View {
        VStack {
            SortFilterSearchView(
                selectedSort: $viewModel.selectedSort,
                selectedFilter: $viewModel.selectedFilter,
                searchText: $viewModel.searchText,
                performRequest: { viewModel.requestData() }
            )
            .padding(.horizontal)
            VStack {
                switch viewModel.state {
                case .initial:
                    EmptyView()
                case .loading:
                    LoadingView()
                case .content:
                    SimpleListContentView(viewItems: viewModel.viewItems, onRefresh: viewModel.requestData)
                case .error:
                    ListErrorView()
                case .empty:
                    EmptyContentView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onDebouncedTextChange(text: viewModel.$searchText, delay: 0.3) {
            viewModel.requestData()
        }
        .onAppear(perform: viewModel.handleOnAppear)
        .onDisappear(perform: viewModel.handleOnDisappear)
    }
}

/// Используется для простых списков без пагинации.
private struct SimpleListContentView: View {
    let viewItems: [ListViewItem]
    let onRefresh: (Bool) -> Void
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewItems) { item in
                    Text(item.id)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 16)
        }
        .refreshable { onRefresh(true) }
    }
}

#Preview {
    SimpleListView(viewModel: SimpleListViewModel(repository: ListRepository()))
}
