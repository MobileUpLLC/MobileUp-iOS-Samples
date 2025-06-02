import Foundation

extension String {
    static let phoneUrlPrefix = "tel://"
    
    func toPhoneUrl() -> URL? {
        return URL(string: Self.phoneUrlPrefix + self.filter { $0.isNumber })
    }
    
    func removeExtraPhoneSymbols() -> String {
        let characterSetToRemove = CharacterSet.extraPhoneSymbols
        let components = self.components(separatedBy: characterSetToRemove)
        
        return components.joined(separator: .empty)
    }
}
