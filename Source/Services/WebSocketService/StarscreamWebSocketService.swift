import Starscream
import Foundation

class StarscreamWebSocketService {
    // swiftlint:disable:next force_unwrapping
    private let url = URL(string: "wss://echo.websocket.org")!
    private var socket: WebSocket?
    private var isConnected: Bool = false
    
    var onMessageReceived: ((String) -> Void)?
    
    func connect() async throws {
        // swiftlint:disable:next unused_closure_parameter
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            var request = URLRequest(url: url)
            request.timeoutInterval = 5
            socket = WebSocket(request: request)
            socket?.delegate = self
            socket?.connect()
        }
    }
    
    func sendMessage(_ message: String) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            guard let socket = socket, isConnected else {
                continuation.resume(
                    throwing: NSError(
                        domain: "",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "WebSocket not connected"]
                    )
                )
                return
            }
            socket.write(string: message)
            continuation.resume(returning: ())
        }
    }
    
    func disconnect() {
        socket?.disconnect()
        isConnected = false
        socket = nil
    }
}

extension StarscreamWebSocketService: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocketClient) {
        switch event {
        case .connected:
            print("WebSocket connected")
            isConnected = true
        case let .disconnected(reason, code):
            print("WebSocket disconnected: \(reason) with code: \(code)")
            isConnected = false
        case .text(let text):
            onMessageReceived?(text)
        case .binary(let data):
            print("Received binary data: \(data)")
        case .error(let error):
            print("WebSocket error: \(error?.localizedDescription ?? "Unknown error")")
            isConnected = false
        default:
            break
        }
    }
}
