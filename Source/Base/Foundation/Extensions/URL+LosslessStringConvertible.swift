import Foundation

extension URL: LosslessStringConvertible {
    var description: String { absoluteString }
    
    public init?(_ description: String) {
        self.init(string: description)
    }
}
