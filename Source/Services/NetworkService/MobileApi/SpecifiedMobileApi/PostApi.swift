import Foundation
import munkit
import Moya

enum PostApi {
    case getPosts
    case getPostDetail(id: String)
}

extension PostApi: MUNAPITarget {
    var parameters: [String: Any] { getParameters() }
    var isAccessTokenRequired: Bool { getIsAccessTokenRequired() }
    var isRefreshTokenRequest: Bool { getIsRefreshTokenRequest() }
    var baseURL: URL { getBaseURL() }
    var path: String { getPath() }
    var method: Moya.Method { getMethod() }
    var task: Moya.Task { getTask() }
    var headers: [String: String]? { getHeaders() }
    var authorizationType: Moya.AuthorizationType? { getAuthorizationType() }
    
    var mockFileName: String? { getmockFileName() }
    var isMockEnabled: Bool { true }
    
    private func getParameters() -> [String: Any] {
        switch self {
        case .getPosts, .getPostDetail:
            return [:]
        }
    }
    
    private func getIsAccessTokenRequired() -> Bool {
        switch self {
        case .getPosts, .getPostDetail:
            return false
        }
    }
    
    private func getIsRefreshTokenRequest() -> Bool {
        switch self {
        case .getPosts, .getPostDetail:
            return false
        }
    }
    
    private func getBaseURL() -> URL {
        switch self {
        case .getPosts, .getPostDetail:
            // swiftlint:disable:next force_unwrapping
            return URL(string: "https://www.example.com")! // Заглушка
        }
    }
    
    private func getPath() -> String {
        switch self {
        case .getPosts, .getPostDetail:
            return "/api/posts" // Заглушка
        }
    }
    
    private func getMethod() -> Moya.Method {
        switch self {
        case .getPosts, .getPostDetail:
            return .get
        }
    }
    
    private func getTask() -> Moya.Task {
        switch self {
        case .getPosts, .getPostDetail:
            return .requestPlain
        }
    }
    
    private func getHeaders() -> [String: String]? {
        switch self {
        case .getPosts, .getPostDetail:
            return [:]
        }
    }
    
    private func getAuthorizationType() -> Moya.AuthorizationType? {
        switch self {
        case .getPosts, .getPostDetail:
            return nil
        }
    }
    
    private func getmockFileName() -> String? {
        switch self {
        case .getPosts:
            return "MockPosts"
        case .getPostDetail(let id):
            return "MockPostDetail\(id)"
        }
    }
}
