import Foundation

extension String {
    static let phoneUrlPrefix = "tel://"
    
    func toPhoneUrl() -> URL? {
        return URL(string: Self.phoneUrlPrefix + self.filter { $0.isNumber })
    }
}
