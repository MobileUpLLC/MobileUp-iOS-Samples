import munkit

actor PostRepository {
    private var onLikePostUpdate: Closure.Generic<LikeModel>? {
        didSet { likeEventBus = EventBus(subscribe: onLikePostUpdate) }
    }
    
    private var likeEventBus = EventBus<LikeModel>()
    private let networkService: MUNNetworkService<MobileApi>
    
    init(networkService: MUNNetworkService<MobileApi>) {
        self.networkService = networkService
    }
    
    func getPosts() async throws -> [ImageModel] {
        return try await networkService.executeRequest(target: .post(.getPosts))
    }
    
    func getPostDetail(id: String) async -> ImageModel? {
//        try? await Task.sleep(nanoseconds: 1_500_000_000)
//        
//        return models[(Int(id) ?? 1) - 1]
        return nil
    }
    
    func postLike(imageId: String, isLike: Bool) async throws {
//        try await Task.sleep(nanoseconds: 1_500_000_000)
//        
//        if Bool.random() {
//            throw URLError(.unknown)
//        }
    }
    
    func sendLikePostEvent(data: LikeModel) {
        likeEventBus.send(event: data)
    }

    func setupLikePostUpdateAction(_ action: Closure.Generic<LikeModel>?) {
        onLikePostUpdate = action
    }

//    func getMessages(chatId: String) async throws -> [Message] {
//        return try await networkService.executeRequest(target: .chat(.getMessages(chatId: chatId)))
//    }
}
