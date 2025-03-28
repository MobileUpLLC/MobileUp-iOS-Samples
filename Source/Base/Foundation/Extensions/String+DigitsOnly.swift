import Foundation

extension String {
    func digitsOnly() -> Int {
        return Int(self.filter { $0.isNumber }) ?? .zero
    }
}
