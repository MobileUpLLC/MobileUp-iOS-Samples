import Foundation

enum ListSortType: String, CaseIterable, Identifiable {
    case `default`
    case ascending
    case descending
    
    var id: String { UUID().uuidString }
}
