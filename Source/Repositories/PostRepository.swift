import Foundation
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
    
    func getPostDetail(id: String) async throws -> ImageModel? {
        return try await networkService.executeRequest(target: .post(.getPostDetail(id: id)))
    }
    
    func postLike(imageId: String, isLike: Bool) async throws {
        try await Task.sleep(nanoseconds: 1_500_000_000)
        
        if Bool.random() {
            throw URLError(.unknown)
        }
    }
    
    func sendLikePostEvent(data: LikeModel) {
        likeEventBus.send(event: data)
    }

    func setupLikePostUpdateAction(_ action: Closure.Generic<LikeModel>?) {
        onLikePostUpdate = action
    }
}
