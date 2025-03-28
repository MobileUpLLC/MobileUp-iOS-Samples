import Foundation

class AuthRepository: TokenRefreshProvider, AccessTokenProvider {
    private enum Constants {
        static let refreshTokenKey = UniqueStorageKey<String>(value: "AuthRepository.refreshTokenKey")
        static let accessTokenKey = UniqueStorageKey<String>(value: "AuthRepository.accessTokenKey")
    }
    
    var accessToken: String? { try? keychainStorageService.object(forKey: Constants.accessTokenKey) }
    var refreshToken: String? { try? keychainStorageService.object(forKey: Constants.refreshTokenKey) }
    
    private let keychainStorageService = KeychainStorageService<String>(
        transformer: KeychainTransformerFactory.forCodable(ofType: String.self)
    )
        
    private lazy var mobileService = MobileService.shared
    
    func refreshToken() async throws -> String {
        try await mobileService.request(target: .auth(.refresh(token: "refreshToken")))
    }
    
    private func removeAllFromKeychaine() throws {
        try keychainStorageService.removeAll()
    }
    
    private func saveRefreshToken(_ token: String) throws {
        try keychainStorageService.setObject(
            token,
            forKey: Constants.refreshTokenKey,
            expiry: .never
        )
    }
    
    private func saveAccessToken(_ token: String) throws {
        try keychainStorageService.setObject(
            token,
            forKey: Constants.accessTokenKey,
            expiry: .never
        )
    }
}
