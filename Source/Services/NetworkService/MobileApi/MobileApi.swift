import Foundation
import Moya

enum MobileApi {
    case auth(AuthApi)
    case example(ExampleApi)
}

extension MobileApi: MobileApiTargetType {
    var baseURL: URL { getBaseUrl() }
    var path: String { getPath() }
    var method: Moya.Method { getMethod() }
    var task: Task { getTask() }
    var parameters: [String: Any] { getParameters() }
    var headers: [String: String]? { getHeaders() }
    var authorizationType: AuthorizationType? { .bearer }
    var isAccessTokenRequired: Bool { getIsAccessTokenRequired() }
    var isRefreshTokenRequest: Bool { getIsRefreshTokenRequest() }

    private func getBaseUrl() -> URL {
        switch self {
        case .example(let type as MobileApiTargetType), .auth(let type as MobileApiTargetType):
            return type.baseURL
        }
    }

    private func getPath() -> String {
        switch self {
        case .example(let type as MobileApiTargetType), .auth(let type as MobileApiTargetType):
            return type.path
        }
    }

    private func getMethod() -> Moya.Method {
        switch self {
        case .example(let type as MobileApiTargetType), .auth(let type as MobileApiTargetType):
            return type.method
        }
    }

    private func getTask() -> Task {
        switch self {
        case .example(let type as MobileApiTargetType), .auth(let type as MobileApiTargetType):
            return type.task
        }
    }

    private func getParameters() -> [String: Any] {
        var params: [String: Any] = [:]

        switch self {
        case .example(let type as MobileApiTargetType), .auth(let type as MobileApiTargetType):
            params = type.parameters
        }

        return params
    }

    private func getHeaders() -> [String: String]? {
        var headers = [
            "Content-Type": "application/json"
        ]
        
        let additionalHeaders: [String: String]?
        
        switch self {
        case .example(let target as MobileApiTargetType), .auth(let target as MobileApiTargetType):
            additionalHeaders = target.headers
            
            if let additionalHeaders {
                additionalHeaders.forEach {
                    headers[$0.key] = $0.value
                }
            }
            
            return headers
        }
    }
    
    private func getIsAccessTokenRequired() -> Bool {
        switch self {
        case .example(let type as MobileApiTargetType), .auth(let type as MobileApiTargetType):
            return type.isAccessTokenRequired
        }
    }
    
    private func getIsRefreshTokenRequest() -> Bool {
        switch self {
        case .auth(let type as MobileApiTargetType):
            return type.isRefreshTokenRequest
        default:
            return false
        }
    }
}
