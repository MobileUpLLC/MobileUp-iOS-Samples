import KeychainAccess
import Foundation

struct KeychainConfig {
    private enum Constants {
        static let defaultStorageName = Environments.mobileApiUrl.absoluteString + "-default"
        static let defaultInMemoryExpiryInSeconds: Double = 60
    }

    let expiry: Expiry
    let keychainIdentifier: String

    static let `default` = KeychainConfig(
        keychainIdentifier: Constants.defaultStorageName,
        expiry: .seconds(Constants.defaultInMemoryExpiryInSeconds)
    )

    init(
        keychainIdentifier: String,
        expiry: Expiry = .never
    ) {
        self.expiry = expiry
        self.keychainIdentifier = keychainIdentifier
    }
}

class KeychainTransformer<T> {
    let toData: (T) throws -> Data
    let fromData: (Data) throws -> T

    init(toData: @escaping (T) throws -> Data, fromData: @escaping (Data) throws -> T) {
        self.toData = toData
        self.fromData = fromData
    }
}

private struct KeychainObject: Codable {
    let expiryDate: Date
    let data: Data
}

enum KeychainTransformerFactory {
    static func forData() -> KeychainTransformer<Data> {
        let toData: (Data) throws -> Data = { $0 }

        let fromData: (Data) throws -> Data = { $0 }

        return KeychainTransformer<Data>(toData: toData, fromData: fromData)
    }

    static func forCodable<U: Codable>(ofType: U.Type) -> KeychainTransformer<U> {
        let toData: (U) throws -> Data = { object in
            let wrapper = TypeWrapper<U>(object: object)
            let encoder = JSONEncoder()
            return try encoder.encode(wrapper)
        }

        let fromData: (Data) throws -> U = { data in
            let decoder = JSONDecoder()
            return try decoder.decode(TypeWrapper<U>.self, from: data).object
        }

        return KeychainTransformer<U>(toData: toData, fromData: fromData)
    }
}

class KeychainStorageService<Value>: Storable {
    typealias Key = UniqueStorageKey<String>
    typealias Value = Value

    var allKeys: [Key] { [] }
    var allObjects: [Value] { [] }

    private let keychain: Keychain
    private let expiry: Expiry
    private let transformer: KeychainTransformer<Value>
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    init(config: KeychainConfig = .default, transformer: KeychainTransformer<Value>) {
        keychain = Keychain(service: config.keychainIdentifier)
            .accessibility(.afterFirstUnlockThisDeviceOnly)
        expiry = config.expiry
        self.transformer = transformer
    }

    func entry(forKey key: Key) throws -> StorageEntry<Value> {
        return try entry(forKey: key.uniqueValue)
    }

    func removeObject(forKey key: Key) throws {
        try removeObject(forKey: key.uniqueValue)
    }

    func setObject(_ object: Value?, forKey key: Key, expiry: Expiry?) throws {
        guard let object else {
            try? removeObject(forKey: key)
            return
        }

        let expiry = expiry ?? self.expiry
        let data = try transformer.toData(object)
        let keychainObject = KeychainObject(expiryDate: expiry.date, data: data)
        let keychainData = try encoder.encode(keychainObject)

        try keychain.set(keychainData, key: key.uniqueValue)
    }

    func removeAll() throws {
        try keychain.removeAll()
    }

    func removeExpiredObjects() throws {
        let allKeys = keychain.allKeys()

        for key in allKeys {
            let entry = try entry(forKey: key)
            let isObjectExpired = entry.expiry.isExpired

            if isObjectExpired {
                try removeObject(forKey: key)
            }
        }
    }

    func removeInMemoryObject(forKey key: Key) throws {
        let message = "Keychain storage. The method does nothing, so the data is stored only in keychain storage"
        Log.keychainStorageService.debug(logEntry: .text(message))
    }

    private func entry(forKey key: String) throws -> StorageEntry<Value> {
        guard let data = try keychain.getData(key) else {
            throw StorageError.notFound
        }

        let keychainObject = try decoder.decode(KeychainObject.self, from: data)
        let object = try transformer.fromData(keychainObject.data)

        return StorageEntry(object: object, expiry: Expiry.date(keychainObject.expiryDate))
    }

    private func removeObject(forKey key: String) throws {
        try keychain.remove(key)
    }
}
