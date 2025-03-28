import Cache
import Foundation

private enum Constants {
    static let persistentStorageName = "PersistentStorage"
    static let persistentStoragePathComponent = "PersistansCaches"
    static let defaultDiskMaxSizeInBytes: UInt = 50_000_000 // ~ 50 мегабайт
    static let defaultInMemoryExpiryInSeconds: Double = 60
}

class DiskStorageService<Key: Hashable, Value>: Storable {
    var allKeys: [Key] { internalStorage.allKeys }
    var allObjects: [Value] { internalStorage.allObjects }

    private let diskConfig: DiskConfig? = {
        if let directory = try? FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ) {
            let diskConfig = DiskConfig(
                // The name of disk storage, this will be used as folder name within directory
                name: Constants.persistentStorageName,
                // Expiry date that will be applied by default for every added object
                // if it's not overridden in the `setObject(forKey:expiry:)` method
                expiry: .never,
                // Maximum size of the disk cache storage (in bytes)
                maxSize: Constants.defaultDiskMaxSizeInBytes,
                // Where to store the disk cache. If nil, it is placed in `cachesDirectory` directory.
                directory: try? FileManager.default.url(
                    for: .applicationSupportDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil,
                    create: true
                )
                .appendingPathComponent(Constants.persistentStoragePathComponent),
                // Data protection is used to store files in an encrypted format on disk and to decrypt them on demand
                protectionType: .complete
            )
            return diskConfig
        }

        return nil
    }()

    private let internalStorage: HybridStorage<Key, Value>

    init?(config: DiskConfig? = nil, transformer: Transformer<Value>) {
        if let diskConfig = config ?? diskConfig,
           let diskStorage = try? Cache.DiskStorage<Key, Value>(config: diskConfig, transformer: transformer) {
            let memoryConfig = MemoryConfig(expiry: .seconds(Constants.defaultInMemoryExpiryInSeconds))
            let memoryStorage = MemoryStorage<Key, Value>(config: memoryConfig)
            let hibridStorage = HybridStorage(memoryStorage: memoryStorage, diskStorage: diskStorage)
            
            self.internalStorage = hibridStorage
        } else {
            return nil
        }
    }

    func entry(forKey key: Key) throws -> StorageEntry<Value> {
        try internalStorage.entry(forKey: key).mapToStorageEntry()
    }

    func removeObject(forKey key: Key) throws {
        try internalStorage.removeObject(forKey: key)
    }

    func setObject(_ object: Value?, forKey key: Key, expiry: Expiry?) throws {
        guard let object else {
            try? removeObject(forKey: key)
            return
        }

        try internalStorage.setObject(object, forKey: key, expiry: expiry)
    }

    func removeAll() throws {
        try internalStorage.removeAll()
    }

    func removeExpiredObjects() throws {
        try internalStorage.removeExpiredObjects()
    }

    func removeInMemoryObject(forKey key: Key) throws {
        try internalStorage.removeInMemoryObject(forKey: key)
    }
}
