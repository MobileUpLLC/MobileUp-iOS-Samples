import Foundation
import Cache

typealias Key = String

enum DataStorageError: Swift.Error {
    case unknown
    case decodingFailed
}

struct DataStorageObject: Codable {
    let expiryDate: Date?
    let data: Data
}

class DataStorageTransform<Value> {
    let toData: (Value) throws -> Data
    let fromData: (Data) throws -> Value

    init(toData: @escaping (Value) throws -> Data, fromData: @escaping (Data) throws -> Value) {
        self.toData = toData
        self.fromData = fromData
    }
}

enum DataStorageTransformFactory {
    static func forCodable<Value: Codable>(ofType: Value.Type) -> DataStorageTransform<Value> {
        let toData: (Value) throws -> Data = { value in
            let encoder = JSONEncoder()
            return try encoder.encode(value)
        }

        let fromData: (Data) throws -> Value = { data in
            let decoder = JSONDecoder()
            return try decoder.decode(Value.self, from: data)
        }

        return DataStorageTransform<Value>(toData: toData, fromData: fromData)
    }
}

class DataStorageService<Value: Codable>: Storable {
    private let internalStorage = UserDefaults.standard
    private var internalAllKeys: Set<Key> = []
    
    private let transform: DataStorageTransform<Value>
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init(transform: DataStorageTransform<Value> = DataStorageTransformFactory.forCodable(ofType: Value.self)) {
        self.transform = transform
    }

    var allKeys: [Key] {
        return Array(internalAllKeys)
    }

    var allObjects: [Value] {
        return internalAllKeys.compactMap { key in
            try? entry(forKey: key).object
        }
    }

    func entry(forKey key: Key) throws -> StorageEntry<Value> {
        guard let data = internalStorage.data(forKey: key) else {
            throw DataStorageError.unknown
        }

        let dataStorageObject = try decoder.decode(DataStorageObject.self, from: data)
        let object = try transform.fromData(dataStorageObject.data)
        let expiry = dataStorageObject.expiryDate.map { Expiry.date($0) } ?? .never
        
        return StorageEntry(object: object, expiry: expiry, filePath: nil)
    }

    func setObject(_ object: Value?, forKey key: Key, expiry: Expiry?) throws {
        guard let object = object else {
            try? removeObject(forKey: key)
            return
        }

        let expiry: Expiry = .never
        let objectData = try transform.toData(object)

        let storageObject = DataStorageObject(expiryDate: expiry.date, data: objectData)

        let encodedStorageObject = try encoder.encode(storageObject)

        internalStorage.set(encodedStorageObject, forKey: key)
        internalAllKeys.insert(key)
    }

    func removeObject(forKey key: Key) throws {
        internalStorage.removeObject(forKey: key)
        internalAllKeys.remove(key)
    }

    func removeAll() throws {
        for key in internalAllKeys {
            try removeObject(forKey: key)
        }
    }

    func removeExpiredObjects() throws {
        for key in allKeys {
            let entry = try entry(forKey: key)
            
            if entry.expiry.isExpired {
                try removeObject(forKey: key)
            }
        }
    }

    func removeInMemoryObject(forKey key: Key) throws {
        let message = "Data storage. The method does nothing, so the data is stored only in user defaults storage"
        Log.dataStorageService.debug(logEntry: .text(message))
    }
}
