import SwiftUI

struct SortFilterSearchView: View {
    @Binding var selectedSort: ListSortType
    @Binding var selectedFilter: ListFilterType
    @Binding var searchText: String
    let performRequest: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Text("Sort:")
                    Picker("Sort", selection: $selectedSort) {
                        ForEach(ListSortType.allCases) { type in
                            Text(type.rawValue.capitalized)
                                .tag(type)
                        }
                    }
                    .onChange(of: selectedSort) { _ in
                        performRequest()
                    }
                }
                Spacer()
                HStack {
                    Text("Filter:")
                    Picker("Filter", selection: $selectedFilter) {
                        ForEach(ListFilterType.allCases) { type in
                            Text(type.rawValue.capitalized)
                                .tag(type)
                        }
                    }
                    .onChange(of: selectedFilter) { _ in
                        performRequest()
                    }
                }
            }
            SortFilterFieldView(text: $searchText, prompt: "Search")
        }
    }
}
