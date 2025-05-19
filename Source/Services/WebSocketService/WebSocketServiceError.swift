enum WebSocketServiceError: Error {
    case notInitialized
    case notConnected
    
    var errorDescription: String? {
        switch self {
        case .notInitialized:
            return "WebSocket is not initialized"
        case .notConnected:
            return "WebSocket is not connected"
        }
    }
}
