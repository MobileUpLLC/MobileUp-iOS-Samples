import Foundation
import munkit
import Moya

enum MobileApi {
    case auth(AuthApi)
    case example(ExampleApi)
}

extension MobileApi: MUNAPITarget {
    var baseURL: URL { getBaseUrl() }
    var path: String { getPath() }
    var method: Moya.Method { getMethod() }
    var task: Task { getTask() }
    var parameters: [String: Any] { getParameters() }
    var headers: [String: String]? { getHeaders() }
    var authorizationType: AuthorizationType? { .bearer }
    var isAccessTokenRequired: Bool { getIsAccessTokenRequired() }
    var isRefreshTokenRequest: Bool { getIsRefreshTokenRequest() }
    var isMockEnabled: Bool { getIsMockEnabled() }
    var mockFileName: String? { getMockFileName() }

    private func getBaseUrl() -> URL {
        switch self {
        case .example(let type as MUNAPITarget), .auth(let type as MUNAPITarget):
            return type.baseURL
        }
    }

    private func getPath() -> String {
        switch self {
        case .example(let type as MUNAPITarget), .auth(let type as MUNAPITarget):
            return type.path
        }
    }

    private func getMethod() -> Moya.Method {
        switch self {
        case .example(let type as MUNAPITarget), .auth(let type as MUNAPITarget):
            return type.method
        }
    }

    private func getTask() -> Task {
        switch self {
        case .example(let type as MUNAPITarget), .auth(let type as MUNAPITarget):
            return type.task
        }
    }

    private func getParameters() -> [String: Any] {
        var params: [String: Any] = [:]

        switch self {
        case .example(let type as MUNAPITarget), .auth(let type as MUNAPITarget):
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
        case .example(let target as MUNAPITarget), .auth(let target as MUNAPITarget):
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
        case .example(let type as MUNAPITarget), .auth(let type as MUNAPITarget):
            return type.isAccessTokenRequired
        }
    }
    
    private func getIsRefreshTokenRequest() -> Bool {
        switch self {
        case .auth(let type as MUNAPITarget):
            return type.isRefreshTokenRequest
        default:
            return false
        }
    }

    private func getMockFileName() -> String? {
        switch self {
        case .auth(let type as MUNAPITarget):
            return type.mockFileName
        case .example:
            return nil
        }
    }

    private func getIsMockEnabled() -> Bool {
        switch self {
        case .auth(let type as MUNAPITarget):
            return type.isMockEnabled
        case .example:
            return false
        }
    }
}
