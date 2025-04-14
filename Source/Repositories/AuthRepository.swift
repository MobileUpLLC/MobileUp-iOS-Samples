import Foundation

class AuthRepository: TokenRefreshProvider, AccessTokenProvider {
    private enum Constants {
        static let refreshTokenKey = UniqueStorageKey<String>(value: "AuthRepository.refreshTokenKey")
        static let accessTokenKey = UniqueStorageKey<String>(value: "AuthRepository.accessTokenKey")
        static let udidKey = UniqueStorageKey<String>(value: "AuthRepository.udidKey")
        static let udidFailureDescription = "Failed to get device UDID"
        static let invalidConfirmationCodeDescription = "Invalid confirmation code"
        static let savedTemporaryTokensDescription = "Temporary tokens saved"
        static let savedTokensDescription = "Tokens saved"
    }
    
    var accessToken: String? { try? keychainStorageService.object(forKey: Constants.accessTokenKey) }
    var refreshToken: String? { try? keychainStorageService.object(forKey: Constants.refreshTokenKey) }
    var udid: String? { try? keychainStorageService.object(forKey: Constants.udidKey) }
    
    var isUserAuthorized: Bool { accessToken != nil }
    
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
        if request.confirmationCode != "1337" {
            let details = ErrorDetails(message: Constants.invalidConfirmationCodeDescription)
            throw ServerError.unknown(details: details)
        }
        let tokenModel: ConfirmCodeTokenModel = try await mobileService.request(
            target: .auth(.checkConfirmationСode(request: request))
        )
        try saveAccessToken(tokenModel.accessToken)
        try saveRefreshToken(tokenModel.refreshToken)
        Log.authRepository.debug(logEntry: .text(Constants.savedTokensDescription))
    }
    
    func register(with request: EmailAuthRequest) async throws {
        let _: UserRegistrationModel = try await mobileService.request(
            target: .auth(.sendConfirmationCode(request: request))
        )
    }
    
    func authorizeUserDevice() async throws {
        guard let udid = try saveUdidIfNeeded() else {
            let details = ErrorDetails(message: Constants.udidFailureDescription)
            throw ServerError.unknown(details: details)
        }
        
        let request = UDIDRequest(udid: udid)
        let tokenModel: TokenModel = try await mobileService.request(
            target: .auth(.authorizeUserDevice(request: request))
        )
        try saveAccessToken(tokenModel.accessToken)
        try saveRefreshToken(tokenModel.refreshToken)
        Log.authRepository.debug(logEntry: .text(Constants.savedTemporaryTokensDescription))
    }
    
    /// Ошибки:
    ///  - В случае, если полученный на вход email не существует, то метод возвращает ошибку – `404 Email not found`.
    ///  - В случае, если полученный на вход email существует, но не подтвержден `is_email_confirmed: false`,
    ///  то метод возвращает ошибку – `419 Resend email verification code`.
    ///  - В случае, если полученный email существует, но пароль неверный,
    ///  то метод возвращает ошибку – `422 Incorrect password`.
    func authorizeUserWithEmail(with request: EmailAuthRequest) async throws {
        if request.email != "test@mobileup.com" {
            throw ServerError.notFound(details: ErrorDetails(statusCode: 404, message: "There is no such user"))
        }
        if request.password != "AbraCadabra13!" {
            throw ServerError.notFound(details: ErrorDetails(statusCode: 422, message: "Incorrect password"))
        }
        let authorizeUserModel: AuthorizeUserModel = try await mobileService.request(
            target: .auth(.authorizeUserWithEmail(request: request))
        )
        try saveAccessToken(authorizeUserModel.accessToken)
        try saveRefreshToken(authorizeUserModel.refreshToken)
    }
    
    func authorizeUserWithPhone(with request: PhoneAuthRequest) async throws {
        let authorizeUserModel: AuthorizeUserModel = try await mobileService.request(
            target: .auth(.authorizeUserWithPhone(request: request))
        )
        try saveAccessToken(authorizeUserModel.accessToken)
        try saveRefreshToken(authorizeUserModel.refreshToken)
    }
    
    @discardableResult
    private func saveUdidIfNeeded() throws -> String? {
        if let udid {
            return udid
        } else {
            let udid = DeviceUtil.udid
            try keychainStorageService.setObject(
                udid,
                forKey: Constants.udidKey,
                expiry: .never
            )
            
            return udid
        }
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
