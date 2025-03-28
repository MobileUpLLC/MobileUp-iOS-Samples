import Foundation

final class StorageViewModel: ObservableObject {
    @Published var text: String = .empty
    @Published var messageInCache: String = .empty
    @Published var messageOnDisk: String = .empty
    @Published var messageInKeychain: String = .empty
    @Published var isShowingAlert = false
    
    private let storageRepository: StorageRepository
    
    init(storageRepository: StorageRepository) {
        self.storageRepository = storageRepository
    }
    
    func onSaveToCacheButtonTapped() {
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            try storageRepository.saveToCache(message: text)
        } onError: { [weak self] _ in
            self?.isShowingAlert = true
        }
    }
    
    func onLoadFromCacheButtonTapped() {
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            let data = try storageRepository.getFromCache() ?? .empty
            
            onMain {
                self.messageInCache = data
            }
        } onError: { [weak self] _ in
            self?.isShowingAlert = true
        }
    }
    
    func onRemoveAllFromCacheButtonTapped() {
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            try storageRepository.removeAllFromCache()
            
            onMain {
                self.messageInCache = .empty
            }
        } onError: { [weak self] _ in
            self?.isShowingAlert = true
        }
    }
    
    func onSaveOnDiskButtonTapped() {
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            try storageRepository.saveOnDisk(message: text)
        } onError: { [weak self] _ in
            self?.isShowingAlert = true
        }
    }
    
    func onLoadFromDiskButtonTapped() {
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            let data = try storageRepository.getFromDisk() ?? .empty
            
            onMain {
                self.messageOnDisk = data
            }
        } onError: { [weak self] _ in
            self?.isShowingAlert = true
        }
    }
    
    func onRemoveAllFromDiskButtonTapped() {
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            try storageRepository.removeAllFromDisk()
            
            onMain {
                self.messageOnDisk = .empty
            }
        } onError: { [weak self] _ in
            self?.isShowingAlert = true
        }
    }
    
    func onSaveToKeychainButtonTapped() {
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            try storageRepository.saveToKeyChain(message: text)
        } onError: { [weak self] _ in
            self?.isShowingAlert = true
        }
    }
    
    func onLoadFromKeychainButtonTapped() {
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            let data = try storageRepository.getFromKeychain() ?? .empty
            
            onMain {
                self.messageInKeychain = data
            }
        } onError: { [weak self] _ in
            self?.isShowingAlert = true
        }
    }
    
    func onRemoveAllFromKeychainButtonTapped() {
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            try storageRepository.removeAllFromKeychaine()
            
            onMain {
                self.messageInKeychain = .empty
            }
        } onError: { [weak self] _ in
            self?.isShowingAlert = true
        }
    }
}
