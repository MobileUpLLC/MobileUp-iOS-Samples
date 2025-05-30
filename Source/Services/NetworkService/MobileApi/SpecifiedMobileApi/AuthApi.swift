import Foundation
import Moya
import munkit

enum AuthApi {
    case refresh(token: String)
    case authorizeUserWithEmail(request: EmailAuthRequest)
    case authorizeUserWithPhone(request: PhoneAuthRequest)
    case sendRecoveryConfirmationCode(request: EmailRequest)
    case sendConfirmationCode(request: EmailAuthRequest)
    case checkConfirmationСode(request: ConfirmationCodeRequest)
    case authorizeUserDevice(request: UDIDRequest)
}

extension AuthApi: MUNAPITarget {
    var baseURL: URL { getBaseURL() }
    var path: String { getPath() }
    var method: Moya.Method { getMethod() }
    var task: Moya.Task { getTask() }
    var parameters: [String: Any] { getParameters() }
    var headers: [String: String]? { getHeaders() }
    var authorizationType: Moya.AuthorizationType? { .none }
    var isAccessTokenRequired: Bool { getIsAccessTokenRequired() }
    var isRefreshTokenRequest: Bool { getIsRefreshTokenRequest() }
    var mockFileName: String? { getMockFileName() }
    var isMockEnabled: Bool { getIsMockEnabled() }

    private func getBaseURL() -> URL { Environments.mobileApiUrl }
    
    private func getPath() -> String {
        switch self {
        case .refresh:
            return "/chains.json"
        case .authorizeUserWithEmail:
            return "/auth-service/api/v1/authWithEmail"
        case .authorizeUserWithPhone:
            return "/auth-service/api/v1/authWithPhone"
        case .sendConfirmationCode:
            return "/auth/email/send_confirmation_code"
        case .checkConfirmationСode:
            return "/auth-service/api/v1/auth/email/checkConfirmationCode"
        case .sendRecoveryConfirmationCode:
            return "/auth-service/api/v1/user/email/sendConfirmationCode"
        case .authorizeUserDevice:
            return "/auth-service/api/v1/auth/userDevice"
        }
    }
    
    private func getMethod() -> Moya.Method {
        switch self {
        case .refresh:
            return .get
        case .authorizeUserWithEmail,
                .sendRecoveryConfirmationCode,
                .checkConfirmationСode,
                .authorizeUserDevice,
                .authorizeUserWithPhone,
                .sendConfirmationCode:
            return .post
        }
    }
    
    private func getTask() -> Moya.Task {
        switch self {
        case .refresh:
            return .requestPlain
        case .authorizeUserWithEmail(let emailAuthRequest):
            return .requestJSONEncodable(emailAuthRequest)
        case .authorizeUserWithPhone(let phoneAuthRequest):
            return .requestJSONEncodable(phoneAuthRequest)
        case .sendRecoveryConfirmationCode(let emailRequest):
            return .requestJSONEncodable(emailRequest)
        case .sendConfirmationCode(let emailAuthRequest):
            return .requestJSONEncodable(emailAuthRequest)
        case .checkConfirmationСode(let codeRequest):
            return .requestJSONEncodable(codeRequest)
        case .authorizeUserDevice(let udidRequest):
            return .requestJSONEncodable(udidRequest)
        }
    }
    
    private func getParameters() -> [String: Any] {
        let params: [String: Any] = [:]
        
        switch self {
        case .refresh,
                .authorizeUserWithEmail,
                .sendRecoveryConfirmationCode,
                .sendConfirmationCode,
                .authorizeUserDevice,
                .authorizeUserWithPhone,
                .checkConfirmationСode:
            break
        }
        
        return params
    }
    
    private func getHeaders() -> [String: String]? {
        let headers: [String: String] = [:]
        
        return headers
    }
        
    private func getIsAccessTokenRequired() -> Bool {
        switch self {
        case .refresh,
                .authorizeUserDevice:
            return false
        case .authorizeUserWithEmail,
                .sendConfirmationCode,
                .authorizeUserWithPhone,
                .sendRecoveryConfirmationCode,
                .checkConfirmationСode:
            return true
        }
    }
    
    private func getIsRefreshTokenRequest() -> Bool {
        switch self {
        case .refresh:
            return true
        case .authorizeUserWithEmail,
                .sendRecoveryConfirmationCode,
                .sendConfirmationCode,
                .authorizeUserDevice,
                .authorizeUserWithPhone,
                .checkConfirmationСode:
            return false
        }
    }
    
    private func getAuthorizationType() -> AuthorizationType? {
        switch self {
        case .sendConfirmationCode,
                .checkConfirmationСode,
                .authorizeUserWithEmail,
                .authorizeUserDevice,
                .refresh,
                .authorizeUserWithPhone,
                .sendRecoveryConfirmationCode:
            return .bearer
        }
    }

    func getMockFileName() -> String? {
        switch self {
        case .refresh:
            return nil
        case .authorizeUserWithEmail, .authorizeUserWithPhone:
            return "MockAuthorizeUserModel"
        case .authorizeUserDevice:
            return "MockTempTokenModel"
        case .sendRecoveryConfirmationCode, .sendConfirmationCode:
            return "MockUserRegistrationModel"
        case .checkConfirmationСode:
            return "MockTokenModel"
        }
    }
    
    private func getIsMockEnabled() -> Bool {
        switch self {
        case .refresh:
            return false
        case .authorizeUserWithEmail,
                .sendRecoveryConfirmationCode,
                .checkConfirmationСode,
                .authorizeUserDevice,
                .authorizeUserWithPhone,
                .sendConfirmationCode:
            return true
        }
    }
}
