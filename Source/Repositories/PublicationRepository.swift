import Foundation

final class PublicationRepository {
    var onLikePostUpdate: Closure.Generic<LikeModel>? {
        didSet { likeEventBus = EventBus(subscribe: onLikePostUpdate) }
    }
    
    private var likeEventBus = EventBus<LikeModel>()
    
    private let models = [
        ImageModel(
            id: "1",
            title: "Image 1",
            imageUrl: "https://picsum.photos/200",
            isLiked: false,
            likeCount: 10
        ),
        ImageModel(
            id: "2",
            title: "Image 2",
            imageUrl: "https://picsum.photos/200",
            isLiked: false,
            likeCount: 5
        ),
        ImageModel(
            id: "3",
            title: "Image 3",
            imageUrl: "https://picsum.photos/200",
            isLiked: false,
            likeCount: 9
        ),
        ImageModel(
            id: "4",
            title: "Image 4",
            imageUrl: "https://picsum.photos/200",
            isLiked: false,
            likeCount: 14
        )
    ]
    
    func getPosts() async -> [ImageModel] {
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        
        return models
    }
    
    func getPostDetail(id: String) async -> ImageModel? {
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        
        return models[(Int(id) ?? 1) - 1]
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
}
