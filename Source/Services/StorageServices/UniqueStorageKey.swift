import Foundation

struct UniqueStorageKey<T: Hashable>: Hashable {
    private let value: T
    private let mobileApi: String

    init(value: T) {
        self.value = value
        self.mobileApi = Environments.mobileApiUrl.absoluteString
    }
}

extension UniqueStorageKey<String> {
    var uniqueValue: String { mobileApi + value }
}
