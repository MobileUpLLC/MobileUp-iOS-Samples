import Foundation

final class LikeService {
    static private var likedImages: [String: LikeState] = [:]
    
    static func updateLikeState(_ likeModel: LikeModel) {
        likedImages[likeModel.imageId] = LikeState(isLiked: likeModel.isLike, likeCount: likeModel.likeCount)
    }
    
    static func getLikeState(imageId: String) -> LikeState? {
        return likedImages[imageId]
    }
    
    static func removeLikeState(imageId: String) {
        likedImages.removeValue(forKey: imageId)
    }
}

struct LikeState {
    let isLiked: Bool
    let likeCount: Int
}

struct LikeModel {
    let imageId: String
    let isLike: Bool
    let likeCount: Int
}

extension LikeModel: Eventable {
    static let eventId = UUID()
}

struct ImageModel {
    let id: String
    let title: String
    let imageUrl: String
    let isLiked: Bool
    let likeCount: Int
}
