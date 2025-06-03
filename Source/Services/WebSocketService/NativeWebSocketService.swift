import Foundation

final class NativeWebSocketService: WebSocketService {
    var onMessageReceived: Closure.String?
    
    private var webSocketTask: URLSessionWebSocketTask?
    
    deinit { disconnect() }
    
    func connect() async throws {
        webSocketTask = URLSession(configuration: .default).webSocketTask(with: Environments.chatWebSocketUrl)
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
