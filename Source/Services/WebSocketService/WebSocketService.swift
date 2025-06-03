protocol WebSocketService: AnyObject {
    var onMessageReceived: Closure.String? { get set }
    func connect() async throws
    func sendMessage(_ message: String) async throws
    func disconnect()
}
