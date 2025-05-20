struct PostModel: Codable {
    let id: String
    let title: String
    let imageUrl: String
    var isLiked: Bool
    let likeCount: Int
}
