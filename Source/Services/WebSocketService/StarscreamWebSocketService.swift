import Foundation
import Starscream

final class StarscreamWebSocketService: WebSocketService {
    var onMessageReceived: Closure.String?
    
    private var socket: WebSocket?
    private var isConnected: Bool = false
    
    deinit { disconnect() }
    
    func connect() async throws {
        try await withCheckedThrowingContinuation { (_: CheckedContinuation<Void, Error>) in
            let request = URLRequest(url: Environments.chatWebSocketUrl, timeoutInterval: 5)
            let socket = WebSocket(request: request)
            
            socket.delegate = self
            self.socket = socket
            
            socket.connect()
        }
    }
    
    func sendMessage(_ message: String) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            guard let socket = socket else {
                continuation.resume(throwing: WebSocketServiceError.notInitialized)
                return
            }
            
            guard isConnected else {
                continuation.resume(throwing: WebSocketServiceError.notConnected)
                return
            }
            
            socket.write(string: message) {
                continuation.resume(returning: ())
            }
        }
    }
    
    func disconnect() {
        socket?.disconnect()
        socket = nil
        isConnected = false
    }
}

extension StarscreamWebSocketService: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocketClient) {
        switch event {
        case .connected:
            isConnected = true
            print("[WebSocket] Connected successfully")
        case let .disconnected(reason, code):
            isConnected = false
            print("[WebSocket] Disconnected: \(reason) (code: \(code))")
        case .text(let text):
            onMessageReceived?(text)
        case .binary(let data):
            print("[WebSocket] Received binary data: \(data.count) bytes")
        case .error(let error):
            isConnected = false
            let errorDescription = error?.localizedDescription ?? "Unknown error"
            print("[WebSocket] Error: \(errorDescription)")
        case .cancelled:
            isConnected = false
            print("[WebSocket] Connection cancelled")
        default:
            break
        }
    }
}
