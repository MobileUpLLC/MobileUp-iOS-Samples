import Foundation

struct LikeModel {
    let imageId: String
    let isLike: Bool
    let likeCount: Int
}

extension LikeModel: Eventable {
    static let eventId = UUID()
}
