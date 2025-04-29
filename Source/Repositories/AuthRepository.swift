import Foundation
import munkit

class AuthRepository: MUNAccessTokenProvider, MUNAccessTokenRefresher, @unchecked Sendable {
    private enum Constants {
        static let refreshTokenKey = UniqueStorageKey<String>(value: "AuthRepository.refreshTokenKey")
        static let accessTokenKey = UniqueStorageKey<String>(value: "AuthRepository.accessTokenKey")
    }

    private let networkService: NetworkService
    private var _accessToken: String?
    private var _refreshToken: String?
    private let tokensQueue: DispatchQueue

    var accessToken: String? { tokensQueue.sync { _accessToken } }
    var refreshToken: String? { tokensQueue.sync { _refreshToken } }

    init(networkService: NetworkService) {
         self.networkService = networkService
         self.tokensQueue = DispatchQueue(
             label: "com.mobileup.auth-repository.access-token-queue",
             qos: .userInitiated
         )
         self._accessToken = try? keychainStorageService.object(forKey: Constants.accessTokenKey)
         self._refreshToken = try? keychainStorageService.object(forKey: Constants.refreshTokenKey)
     }

    func refresh() async throws {
        try await networkService.executeRequest(target: .auth(.refresh(token: "refreshToken")))
    }

    private let keychainStorageService = KeychainStorageService<String>(
        transformer: KeychainTransformerFactory.forCodable(ofType: String.self)
    )

    private func removeAllFromKeychaine() throws {
        try tokensQueue.sync {
            try keychainStorageService.removeAll()
        }
    }
    
    private func saveRefreshToken(_ token: String) throws {
        try tokensQueue.sync {
            _refreshToken = token

            try keychainStorageService.setObject(
                token,
                forKey: Constants.refreshTokenKey,
                expiry: .never
            )
        }
    }
    
    private func saveAccessToken(_ token: String) throws {
        try tokensQueue.sync {
            _accessToken = token

            try keychainStorageService.setObject(
                token,
                forKey: Constants.accessTokenKey,
                expiry: .never
            )
        }
    }
}
