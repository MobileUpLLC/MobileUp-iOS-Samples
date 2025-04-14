import Foundation

enum ListFilterType: String, CaseIterable, Identifiable {
    case `default`
    case odd
    case even
    
    var id: String { UUID().uuidString }
}
