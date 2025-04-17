import SwiftUI

struct SwiftUIListView: View {
    @ObservedObject var viewModel: SwiftUIListViewModel
        
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
                    SwiftUIListContentView(viewItems: viewModel.viewItems, onRefresh: viewModel.requestDataAsync)
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

private struct SwiftUIListContentView: View {
    let viewItems: [ListViewItem]
    let onRefresh: (Bool) async -> Void
    
    var body: some View {
        List(viewItems) { item in
            Text(item.id)
        }
        .refreshable { await onRefresh(true) }
    }
}

#Preview {
    SwiftUIListView(viewModel: SwiftUIListViewModel(repository: ListRepository()))
}
