import Foundation

extension Array where Element: Hashable {
    mutating func replace(element: Element, with newElement: Element) {
        guard let index = firstIndex(of: element) else {
            return
        }
        
        self[index] = newElement
    }
}
