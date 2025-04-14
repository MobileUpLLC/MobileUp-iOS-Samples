import SwiftUI

struct ListsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(
                    "Simple List",
                    destination: SimpleListView(
                        viewModel: SimpleListViewModel(repository: ListRepository())
                    )
                )
                NavigationLink(
                    "Pinned Header Footer List",
                    destination: PinnedHeaderFooterListView(
                        viewModel: PinnedHeaderFooterListViewModel(repository: ListRepository())
                    )
                )
                NavigationLink(
                    "SwiftUI List",
                    destination: SwiftUIListView(
                        viewModel: SwiftUIListViewModel(repository: ListRepository())
                    )
                )
                NavigationLink(
                    "Pagination List",
                    destination: PaginationListView(
                        viewModel: PaginationListViewModel(repository: ListRepository())
                    )
                )
                
                Button("Close") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    ListsView()
}
