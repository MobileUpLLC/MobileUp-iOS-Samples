import Foundation
import Moya

enum ExampleApi {
    case testItems
}

extension ExampleApi: MobileApiTargetType {
    var baseURL: URL { getBaseURL() }
    var path: String { getPath() }
    var method: Moya.Method { getMethod() }
    var task: Moya.Task { getTask() }
    var parameters: [String: Any] { getParameters() }
    var headers: [String: String]? { getHeaders() }
    var authorizationType: Moya.AuthorizationType? { .none }
    var isAccessTokenRequired: Bool { getIsAccessTokenRequired() }
    var isRefreshTokenRequest: Bool { false }
        
    private func getBaseURL() -> URL { Environments.mobileApiUrl }
    
    private func getPath() -> String {
        switch self {
        case .testItems:
            return "/chains.json"
        }
    }
    
    private func getMethod() -> Moya.Method {
        switch self {
        case .testItems:
            return .get
        }
    }
    
    private func getTask() -> Moya.Task {
        switch self {
        case .testItems:
            return .requestPlain
        }
    }
    
    private func getParameters() -> [String: Any] {
        switch self {
        case .testItems:
            break
        }
        
        return [:]
    }
    
    private func getHeaders() -> [String: String]? {
        let headers: [String: String] = [:]
        
        return headers
    }
    
    private func getIsAccessTokenRequired() -> Bool {
        switch self {
        case .testItems:
            return true
        }
    }
}
