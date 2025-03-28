import Cache

typealias MemoryStorage = Cache.MemoryStorage
typealias HybridStorage = Cache.HybridStorage
typealias StorageAware = Cache.StorageAware
typealias Transformer = Cache.Transformer
typealias TransformerFactory = Cache.TransformerFactory
typealias Expiry = Cache.Expiry
typealias Entry = Cache.Entry
typealias StorageError = Cache.StorageError
typealias TypeWrapper = Cache.TypeWrapper
typealias MemoryConfig = Cache.MemoryConfig
typealias DiskConfig = Cache.DiskConfig

struct StorageEntry<T> {
    let object: T
    let expiry: Expiry
    let filePath: String?

    init(object: T, expiry: Expiry, filePath: String? = nil) {
        self.object = object
        self.expiry = expiry
        self.filePath = filePath
    }
}

extension Entry {
    func mapToStorageEntry() -> StorageEntry<T> {
        return .init(object: object, expiry: expiry, filePath: filePath)
    }
}

protocol Storable {
    associatedtype Key: Hashable
    associatedtype Value

    var allKeys: [Key] { get }
    var allObjects: [Value] { get }

    func object(forKey key: Key) throws -> Value
    func entry(forKey key: Key) throws -> StorageEntry<Value>
    func removeObject(forKey key: Key) throws
    func setObject(_ object: Value?, forKey key: Key, expiry: Expiry?) throws
    func objectExists(forKey key: Key) -> Bool
    func removeAll() throws
    func removeExpiredObjects() throws
    func isExpiredObject(forKey key: Key) throws -> Bool
    func removeInMemoryObject(forKey key: Key) throws
}

extension Storable {
    func object(forKey key: Key) throws -> Value {
        return try entry(forKey: key).object
    }

    func existsObject(forKey key: Key) throws -> Bool {
        do {
            let _: Value = try object(forKey: key)
            return true
        } catch {
            return false
        }
    }

    func objectExists(forKey key: Key) -> Bool {
        do {
            let _: Value = try object(forKey: key)
            return true
        } catch {
            return false
        }
    }

    func isExpiredObject(forKey key: Key) throws -> Bool {
        do {
            let entry = try self.entry(forKey: key)
            return entry.expiry.isExpired
        } catch {
            return true
        }
    }
}
