import Cache

protocol CacheStorable {
    func fetchDataWithCache<StorageServiceType: Storable, NetworkServiceType: NetworkService>(
        storageService: StorageServiceType?,
        networkService: NetworkServiceType,
        key: StorageServiceType.Key,
        expiry: Expiry,
        isForceRefresh: Bool,
        isNeedToRemoveExpiredDataInCache: Bool,
        fetchData: @escaping (_ networkService: NetworkServiceType) async throws -> StorageServiceType.Value
    ) async throws -> StorageServiceType.Value

    func saveData<StorageServiceType: Storable>(
        storage: StorageServiceType,
        object: StorageServiceType.Value,
        key: StorageServiceType.Key,
        expiry: Expiry
    )

    func getData<StorageServiceType: Storable>(
        storage: StorageServiceType,
        key: StorageServiceType.Key
    ) -> StorageServiceType.Value?

    func removeExpiredObject<StorageServiceType: Storable>(
        storage: StorageServiceType,
        key: StorageServiceType.Key
    ) -> Bool
}

extension CacheStorable {
    func fetchDataWithCache<StorageServiceType: Storable, NetworkServiceType: NetworkService>(
        storageService: StorageServiceType?,
        networkService: NetworkServiceType,
        key: StorageServiceType.Key,
        expiry: Expiry = .seconds(300),
        isForceRefresh: Bool = false,
        isNeedToRemoveExpiredDataInCache: Bool = true,
        fetchData: @escaping (_ networkService: NetworkServiceType) async throws -> StorageServiceType.Value
    ) async throws -> StorageServiceType.Value {
        guard let storageService else {
            return try await fetchData(networkService)
        }

        if isForceRefresh == false {
            let isExistsObject = isExistsObject(storage: storageService, key: key)
            let isExpiredObject = isExpiredObject(storage: storageService, key: key)
            var isRemovedExpiredObject = false

            if isExistsObject, isExpiredObject, isNeedToRemoveExpiredDataInCache {
                isRemovedExpiredObject = removeExpiredObject(storage: storageService, key: key)
            }

            if
                isRemovedExpiredObject == false,
                isExpiredObject == false,
                let cachedValue = getData(storage: storageService, key: key)
            {
                return cachedValue
            }
        }

        let response = try await fetchData(networkService)

        saveData(storage: storageService, object: response, key: key, expiry: expiry)

        return response
    }

    func saveData<StorageServiceType: Storable>(
        storage: StorageServiceType,
        object: StorageServiceType.Value,
        key: StorageServiceType.Key,
        expiry: Expiry = .seconds(300)
    ) {
        do {
            try storage.setObject(object, forKey: key, expiry: expiry)
            
            Log.cacheStorable.debug(logEntry: .detailed(
                text: "Object saved to cache",
                parameters: ["key": key, "Object details": object]
            ))
        } catch let error {
            Log.cacheStorable.error(logEntry: .detailed(
                text: "Error occurred while saving data",
                parameters: ["key": key, "Error details": error]
            ))
        }
    }

    func getData<StorageServiceType: Storable>(
        storage: StorageServiceType,
        key: StorageServiceType.Key
    ) -> StorageServiceType.Value? {
        do {
            let object = try storage.object(forKey: key)
            
            Log.cacheStorable.debug(logEntry: .detailed(
                text: "Object retrieved from cache",
                parameters: ["key": key, "Object details": object]
            ))
            
            return object
        } catch let error {
            Log.cacheStorable.error(logEntry: .detailed(
                text: "Error occurred while retrieving data",
                parameters: ["key": key, "Error details": error]
            ))
        }

        return nil
    }

    func removeExpiredObject<StorageServiceType: Storable>(
        storage: StorageServiceType,
        key: StorageServiceType.Key
    ) -> Bool {
        do {
            if isExpiredObject(storage: storage, key: key) {
                try storage.removeObject(forKey: key)
                
                Log.cacheStorable.debug(logEntry: .text("Object removed for key:\n\(key)"))
                
                return true
            } else {
                Log.cacheStorable.debug(logEntry: .text("Object not expired for key:\n\(key)"))
            }
        } catch let error {
            Log.cacheStorable.error(logEntry: .detailed(
                text: "Error occurred while removing data",
                parameters: ["key": key, "Error details": error]
            ))
        }

        return false
    }

    private func isExpiredObject<StorageServiceType: Storable>(
        storage: StorageServiceType,
        key: StorageServiceType.Key
    ) -> Bool {
        do {
            if try storage.isExpiredObject(forKey: key) {
                Log.cacheStorable.debug(logEntry: .text("Object expired for key:\n\(key)"))
                return true
            } else {
                Log.cacheStorable.debug(logEntry: .text("Object not expired for key:\n\(key)"))
            }
        } catch let error {
            Log.cacheStorable.error(logEntry: .detailed(
                text: "isExpiredObject",
                parameters: ["key": key, "Error details": error]
            ))
        }
        return false
    }

    private func isExistsObject<StorageServiceType: Storable>(
        storage: StorageServiceType,
        key: StorageServiceType.Key
    ) -> Bool {
        do {
            if try storage.existsObject(forKey: key) {
                Log.cacheStorable.debug(logEntry: .text("Object exists for key:\n\(key)"))
                return true
            } else {
                Log.cacheStorable.debug(logEntry: .text("Object not exists for key:\n\(key)"))
            }
        } catch let error {
            Log.cacheStorable.error(logEntry: .detailed(
                text: "isExistsObject",
                parameters: ["key": key, "Error details": error]
            ))
        }
        return false
    }
}
