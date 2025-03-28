import Foundation

final class StorageRepository {
    private enum Constants {
        static let getStorageKey = UniqueKey(value: "StorageRepository.getStorageKey")
        static let expiryInSeconds: Expiry = .seconds(300)
    }
    
    private typealias UniqueKey = UniqueStorageKey<String>
    
    static let shared = StorageRepository()
    
    private init() {}
    
    private let ramMemoryStorage = RamMemoryStorageService<UniqueKey, String>()
    
    private let diskStorageService = DiskStorageService<UniqueKey, String>(
        transformer: TransformerFactory.forCodable(ofType: String.self)
    )
    
    private let keychainStorageService = KeychainStorageService<String>(
        transformer: KeychainTransformerFactory.forCodable(ofType: String.self)
    )
    
    func getFromCache() throws -> String? {
        try ramMemoryStorage?.object(forKey: Constants.getStorageKey)
    }
    
    func saveToCache(message: String) throws {
        try ramMemoryStorage?.setObject(message, forKey: Constants.getStorageKey, expiry: Constants.expiryInSeconds)
    }
    
    func removeAllFromCache() throws {
        try ramMemoryStorage?.removeAll()
    }
    
    func saveOnDisk(message: String) throws {
        try diskStorageService?.setObject(
            message,
            forKey: Constants.getStorageKey,
            expiry: Constants.expiryInSeconds
        )
    }
    
    func getFromDisk() throws -> String? {
        try diskStorageService?.object(forKey: Constants.getStorageKey)
    }
    
    func removeAllFromDisk() throws {
        try diskStorageService?.removeAll()
    }
    
    func saveToKeyChain(message: String) throws {
        try keychainStorageService.setObject(
            message,
            forKey: Constants.getStorageKey,
            expiry: Constants.expiryInSeconds
        )
    }
    
    func getFromKeychain() throws -> String? {
        try keychainStorageService.object(forKey: Constants.getStorageKey)
    }
    
    func removeAllFromKeychaine() throws {
        try keychainStorageService.removeAll()
    }
}
