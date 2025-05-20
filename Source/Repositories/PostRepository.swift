import Foundation
import munkit

actor PostRepository {
    private enum Constants {
        static let postsStorageKey = "Posts"
    }
    
    private var onLikePostUpdate: Closure.Generic<LikeModel>? {
        didSet { likeEventBus = EventBus(subscribe: onLikePostUpdate) }
    }
    
    private var likeEventBus = EventBus<LikeModel>()
    private let dataStorage: DataStorageService<[PostModel]>
    
    init(dataStorage: DataStorageService<[PostModel]>) {
        self.dataStorage = dataStorage
    }
    
    func getPosts() async throws -> [PostModel] {
        guard let posts = try? dataStorage.object(forKey: Constants.postsStorageKey) else {
            throw URLError(.unknown)
        }
        
        return posts
    }
    
    func getPostDetail(id: String) async throws -> PostModel? {
        guard
            let posts = try? dataStorage.object(forKey: Constants.postsStorageKey),
            let post = posts.first(where: { $0.id == id })
        else {
            throw URLError(.unknown)
        }
        
        return post
    }
    
    func postLike(imageId: String, isLike: Bool) async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        if Bool.random() {
            guard
                var posts = try? dataStorage.object(forKey: Constants.postsStorageKey),
                let postIndex = posts.firstIndex(where: { $0.id == imageId })
            else {
                throw URLError(.unknown)
            }
            
            posts[postIndex].isLiked.toggle()
            
            try? dataStorage.setObject(posts, forKey: Constants.postsStorageKey, expiry: .never)
        } else {
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
