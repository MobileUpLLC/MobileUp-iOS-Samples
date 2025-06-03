import Foundation

protocol PostLikeableViewModel: ObservableObject {
    var postRepository: PostRepository { get }
    var likeService: LikeService { get }
    
    func performLikeAction(
        imageId: String,
        isLiked: Bool,
        currentLikeCount: Int,
        errorHandler: Closure.Generic<Error>?
    )
    
    func handleLikeUpdate(with likeModel: LikeModel)
    func setupLikePostUpdateAction()
}

extension PostLikeableViewModel {
    func performLikeAction(
        imageId: String,
        isLiked: Bool,
        currentLikeCount: Int,
        errorHandler: Closure.Generic<Error>?
    ) {
        Task {
            // Оптимистичное обновление
            let newLikeCount = currentLikeCount + (isLiked ? 1 : -1)
            await likeService.updateLikeState(LikeModel(imageId: imageId, isLike: isLiked, likeCount: newLikeCount))
            
            // Отправка события через EventBus
            let event = LikeModel(imageId: imageId, isLike: isLiked, likeCount: newLikeCount)
            await postRepository.sendLikePostEvent(data: event)
            
            // Сетевой запрос
            do {
                try await postRepository.postLike(imageId: imageId, isLike: isLiked)
                await likeService.removeLikeState(imageId: imageId)
            } catch {
                await likeService.removeLikeState(imageId: imageId)
                
                let event = LikeModel(imageId: imageId, isLike: !isLiked, likeCount: currentLikeCount)
                await postRepository.sendLikePostEvent(data: event)
                
                errorHandler?(error)
            }
        }
    }
    
    func setupLikePostUpdateAction() {
        Task {
            await postRepository.setupLikePostUpdateAction { [weak self] likeModel in
                self?.handleLikeUpdate(with: likeModel)
            }
        }
    }
}
