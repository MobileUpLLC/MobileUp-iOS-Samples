import Foundation

protocol ImageLikeMakableViewModel: AnyObject {
    var publicationRepository: PublicationRepository { get }
    
    func performLikeAction(
        imageId: String,
        isLike: Bool,
        currentLikeCount: Int,
        errorHandler: Closure.Generic<Error>?
    )
    
    func handleLikeUpdate(with likeModel: LikeModel)
}

extension ImageLikeMakableViewModel {
    func performLikeAction(
        imageId: String,
        isLike: Bool,
        currentLikeCount: Int,
        errorHandler: Closure.Generic<Error>?
    ) {
        // Оптимистичное обновление
        let newLikeCount = currentLikeCount + (isLike ? 1 : -1)
        LikeService.updateLikeState(LikeModel(imageId: imageId, isLike: isLike, likeCount: newLikeCount))
        
        // Отправка события через EventBus
        let event = LikeModel(imageId: imageId, isLike: isLike, likeCount: newLikeCount)
        publicationRepository.sendLikePostEvent(data: event)
        
        // Сетевой запрос
        Perform { [weak self] in
            try await self?.publicationRepository.postLike(imageId: imageId, isLike: isLike)
            
            // Закомментировано из-за отсутствия реального бека для имитации успешного поста лайка/анлайка
//            LikeService.removeLikeState(imageId: imageId)
        } onError: { [weak self] error in
            LikeService.removeLikeState(imageId: imageId)
            
            let event = LikeModel(imageId: imageId, isLike: !isLike, likeCount: currentLikeCount)
            self?.publicationRepository.sendLikePostEvent(data: event)
            
            errorHandler?(error)
        }
    }
}
