import Foundation

class WebSocketNativeService {
    // swiftlint:disable:next force_unwrapping
    private let url = URL(string: "wss://echo.websocket.org")!
    private var webSocketTask: URLSessionWebSocketTask?
    
    var onMessageReceived: Closure.String?
    
    func connect() async throws {
        webSocketTask = URLSession(configuration: .default).webSocketTask(with: url)
        webSocketTask?.resume()
        
        try await receiveMessages()
    }
    
    func sendMessage(_ message: String) async throws {
        let message = URLSessionWebSocketTask.Message.string(message)
        
        try await webSocketTask?.send(message)
    }
    
    private func receiveMessages() async throws {
        while let message = try await webSocketTask?.receive() {
            switch message {
            case .string(let text):
                onMessageReceived?(text)
            case .data(let data):
                print("Received data: \(data)")
            @unknown default:
                break
            }
        }
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
}
