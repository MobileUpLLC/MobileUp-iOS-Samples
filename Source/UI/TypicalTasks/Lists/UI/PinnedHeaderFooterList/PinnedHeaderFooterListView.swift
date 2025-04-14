import SwiftUI

struct PinnedHeaderFooterListView: View {
    @ObservedObject var viewModel: PinnedHeaderFooterListViewModel
    
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
                    PinnedHeaderFooterListContentView(viewItems: viewModel.viewItems, onRefresh: viewModel.requestData)
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

/// Используется для простых списков без пагинации, но где есть необходимость закрепить header и/или footer.
/// Также может использоваться, если в списке много элементов и присутствуют лаги на UI из-за рендера сразу всех вью.
private struct PinnedHeaderFooterListContentView: View {
    let viewItems: [ListViewItem]
    let onRefresh: (Bool) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack(pinnedViews: [.sectionHeaders, .sectionFooters]) {
                Section {
                    ForEach(viewItems) { item in
                        Text(item.id)
                    }
                } header: {
                    Text("HEADER")
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                } footer: {
                    Text("FOOTER")
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 16)
        }
        .refreshable { onRefresh(true) }
    }
}

#Preview {
    PinnedHeaderFooterListView(viewModel: PinnedHeaderFooterListViewModel(repository: ListRepository()))
}
