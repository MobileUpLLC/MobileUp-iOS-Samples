actor LikeService {
    struct LikeState: Decodable {
        let isLiked: Bool
        let likeCount: Int
    }
    
    private var likedImages: [String: LikeState] = [:]
    
    func updateLikeState(_ likeModel: LikeModel) {
        likedImages[likeModel.imageId] = LikeState(isLiked: likeModel.isLike, likeCount: likeModel.likeCount)
    }
    
    func getLikeState(imageId: String) -> LikeState? {
        likedImages[imageId]
    }
    
    func removeLikeState(imageId: String) {
        likedImages.removeValue(forKey: imageId)
    }
}
