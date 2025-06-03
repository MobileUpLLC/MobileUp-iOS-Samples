import munkit

actor ChatRepository {
    private let networkService: MUNNetworkService<MobileApi>

    init(networkService: MUNNetworkService<MobileApi>) {
        self.networkService = networkService
    }

    func getMessages(chatId: String) async throws -> [Message] {
        return try await networkService.executeRequest(target: .chat(.getMessages(chatId: chatId)))
    }
}
