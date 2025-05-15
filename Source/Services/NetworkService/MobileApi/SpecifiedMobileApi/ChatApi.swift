import munkit
import Moya
import Foundation

enum ChatApi {
    case getMessages(chatId: String)
}

extension ChatApi: MUNAPITarget {
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
        case .getMessages:
            return [:]
        }
    }
    
    private func getIsAccessTokenRequired() -> Bool {
        switch self {
        case .getMessages:
            return false
        }
    }
    
    private func getIsRefreshTokenRequest() -> Bool {
        switch self {
        case .getMessages:
            return false
        }
    }
    
    // swiftlint:disable force_unwrapping
    private func getBaseURL() -> URL {
        switch self {
        case .getMessages:
            return URL(string: "https://www.example.com")! // Заглушка
        }
    }
    // swiftlint:enable force_unwrapping
    
    private func getPath() -> String {
        switch self {
        case .getMessages:
            return "/api/messages" // Заглушка
        }
    }
    
    private func getMethod() -> Moya.Method {
        switch self {
        case .getMessages:
            return .get
        }
    }
    
    private func getTask() -> Moya.Task {
        switch self {
        case .getMessages:
            return .requestPlain
        }
    }
    
    private func getHeaders() -> [String: String]? {
        switch self {
        case .getMessages:
            return [:]
        }
    }
    
    private func getAuthorizationType() -> Moya.AuthorizationType? {
        switch self {
        case .getMessages:
            return nil
        }
    }
    
    private func getmockFileName() -> String? {
        return "MockMessages"
    }
}
