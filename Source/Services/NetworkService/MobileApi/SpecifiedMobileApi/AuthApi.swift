import Foundation
import Moya

enum AuthApi {
    case refresh(token: String)
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
        }
    }
    
    private func getMethod() -> Moya.Method {
        switch self {
        case .refresh:
            return .get
        }
    }
    
    private func getTask() -> Moya.Task {
        switch self {
        case .refresh:
            return .requestPlain
        }
    }
    
    private func getParameters() -> [String: Any] {
        let params: [String: Any] = [:]
        
        switch self {
        case .refresh:
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
        }
    }
    
    private func getIsRefreshTokenRequest() -> Bool {
        switch self {
        case .refresh:
            return true
        }
    }
}
