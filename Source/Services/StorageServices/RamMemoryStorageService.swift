import Foundation

private enum Constants {
    static let defaultInMemoryExpiryInSeconds: Double = 60
}

extension MemoryConfig {
    static var `default`: MemoryConfig { .init(expiry: .seconds(Constants.defaultInMemoryExpiryInSeconds)) }
}

class RamMemoryStorageService<Key: Hashable, Value>: Storable {
    var allKeys: [Key] { internalStorage.allKeys }
    var allObjects: [Value] { internalStorage.allObjects }

    private let internalStorage: MemoryStorage<Key, Value>

    init?(config: MemoryConfig = .default) {
        let memoryConfig: MemoryConfig = config
        let memoryStorage = MemoryStorage<Key, Value>(config: memoryConfig)
        self.internalStorage = memoryStorage
    }

    func entry(forKey key: Key) throws -> StorageEntry<Value> {
        try internalStorage.entry(forKey: key).mapToStorageEntry()
    }

    func removeObject(forKey key: Key) throws {
        internalStorage.removeObject(forKey: key)
    }

    func setObject(_ object: Value?, forKey key: Key, expiry: Expiry?) throws {
        guard let object else {
            try? removeObject(forKey: key)
            return
        }

        internalStorage.setObject(object, forKey: key, expiry: expiry)
    }

    func removeAll() throws {
        internalStorage.removeAll()
    }

    func removeExpiredObjects() throws {
        internalStorage.removeExpiredObjects()
    }

    func removeInMemoryObject(forKey key: Key) throws {
        try internalStorage.removeInMemoryObject(forKey: key)
    }
}
