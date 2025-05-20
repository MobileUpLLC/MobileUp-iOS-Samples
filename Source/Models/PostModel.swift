struct PostModel: Decodable {
    let id: String
    let title: String
    let imageUrl: String
    let isLiked: Bool
    let likeCount: Int
}
