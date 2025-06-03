enum WebSocketServiceError: Error {
    case notInitialized
    case notConnected
    
    var errorDescription: String? {
        switch self {
        case .notInitialized:
            return R.string.common.webSocketNotInitializationErrorDescription()
        case .notConnected:
            return R.string.common.webSocketNotConnectedErrorDescription()
        }
    }
}
