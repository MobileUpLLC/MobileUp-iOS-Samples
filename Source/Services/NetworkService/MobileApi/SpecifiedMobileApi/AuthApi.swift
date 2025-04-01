import Foundation
import Moya

enum AuthApi {
    case refresh(token: String)
    case authorizeUser(request: EmailAuthRequest)
    case sendRecoveryConfirmationCode(request: EmailRequest)
    case checkConfirmationСode(request: ConfirmationCodeRequest)
}

extension AuthApi: MobileApiTargetType {
    var baseURL: URL { getBaseURL() }
    var path: String { getPath() }
    var method: Moya.Method { getMethod() }
    var task: Moya.Task { getTask() }
    var parameters: [String: Any] { getParameters() }
    var headers: [String: String]? { getHeaders() }
    var authorizationType: Moya.AuthorizationType? { .none }
    var isAccessTokenRequired: Bool { getIsAccessTokenRequired() }
    var isRefreshTokenRequest: Bool { getIsRefreshTokenRequest() }
    
    private func getBaseURL() -> URL { Environments.mobileApiUrl }
    
    private func getPath() -> String {
        switch self {
        case .refresh:
            return "/chains.json"
        case .authorizeUser:
            return "/auth-service/api/v1/auth"
        case .checkConfirmationСode:
            return "/auth-service/api/v1/auth/email/checkConfirmationCode"
        case .sendRecoveryConfirmationCode:
            return "/auth-service/api/v1/user/email/sendConfirmationCode"
        }
    }
    
    private func getMethod() -> Moya.Method {
        switch self {
        case .refresh:
            return .get
        case .authorizeUser,
                .sendRecoveryConfirmationCode,
                .checkConfirmationСode:
            return .post
        }
    }
    
    private func getTask() -> Moya.Task {
        switch self {
        case .refresh:
            return .requestPlain
        case .authorizeUser(let emailAuthRequest):
            return .requestJSONEncodable(emailAuthRequest)
        case .sendRecoveryConfirmationCode(let emailRequest):
            return .requestJSONEncodable(emailRequest)
        case .checkConfirmationСode(let codeRequest):
            return .requestJSONEncodable(codeRequest)
        }
    }
    
    private func getParameters() -> [String: Any] {
        let params: [String: Any] = [:]
        
        switch self {
        case .refresh,
                .authorizeUser,
                .sendRecoveryConfirmationCode,
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
        case .refresh:
            return false
        case .authorizeUser,
                .sendRecoveryConfirmationCode,
                .checkConfirmationСode:
            return true
        }
    }
    
    private func getIsRefreshTokenRequest() -> Bool {
        switch self {
        case .refresh:
            return true
        case .authorizeUser,
                .sendRecoveryConfirmationCode,
                .checkConfirmationСode:
            return false
        }
    }
}
