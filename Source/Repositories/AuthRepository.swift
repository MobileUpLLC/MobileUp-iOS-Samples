import Foundation

class AuthRepository: TokenRefreshProvider, AccessTokenProvider {
    private enum Constants {
        static let refreshTokenKey = UniqueStorageKey<String>(value: "AuthRepository.refreshTokenKey")
        static let accessTokenKey = UniqueStorageKey<String>(value: "AuthRepository.accessTokenKey")
        static let savedTokensDescription = "Tokens saved"
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
    
    func sendRecoveryConfirmationCode(with request: EmailRequest) async throws {
        let _: UserRegistrationModel = try await mobileService.request(
            target: .auth(.sendRecoveryConfirmationCode(request: request))
        )
    }
    
    func clearKeychainDataInStorage() throws {
        try removeAllFromKeychaine()
    }
    
    func checkConfirmationСode(with request: ConfirmationCodeRequest) async throws {
        let tokenModel: ConfirmCodeTokenModel = try await mobileService.request(
            target: .auth(.checkConfirmationСode(request: request))
        )
        try saveAccessToken(tokenModel.accessToken)
        try saveRefreshToken(tokenModel.refreshToken)
        Log.authRepository.debug(logEntry: .text(Constants.savedTokensDescription))
    }
    
    /// Ошибки:
    ///  - В случае, если полученный на вход email не существует, то метод возвращает ошибку – `404 Email not found`.
    ///  - В случае, если полученный на вход email существует, но не подтвержден `is_email_confirmed: false`,
    ///  то метод возвращает ошибку – `419 Resend email verification code`.
    ///  - В случае, если полученный email существует, но пароль неверный,
    ///  то метод возвращает ошибку – `422 Incorrect password`.
    func authorizeUser(with request: EmailAuthRequest) async throws {
        let authorizeUserModel: AuthorizeUserModel = try await mobileService.request(
            target: .auth(.authorizeUser(request: request))
        )
        try saveAccessToken(authorizeUserModel.accessToken)
        try saveRefreshToken(authorizeUserModel.refreshToken)
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
