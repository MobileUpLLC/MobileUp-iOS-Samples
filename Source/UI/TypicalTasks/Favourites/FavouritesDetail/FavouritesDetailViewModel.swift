import Foundation

final class FavouritesDetailViewModel: PostLikeableViewModel {
    enum ViewState {
        case initial
        case loading
        case content
        case error
    }
    
    @Published private(set) var state: ViewState = .initial
    @Published private(set) var viewItem: FavouritesDetailViewItem?
    
    let postRepository: PostRepository
    let likeService: LikeService
    
    private let coordinator: FavouritesDetailCoordinator
    private let imageId: String
    
    init(
        coordinator: FavouritesDetailCoordinator,
        postRepository: PostRepository,
        likeService: LikeService,
        imageId: String
    ) {
        self.coordinator = coordinator
        self.postRepository = postRepository
        self.likeService = likeService
        self.imageId = imageId
        
        setupLikePostUpdateAction()
        loadImage()
    }
    
    func handleLikeUpdate(with likeModel: LikeModel) {
        guard imageId == likeModel.imageId else {
            return
        }
        
        updateViewItem(isLiked: likeModel.isLike, likeCount: likeModel.likeCount)
    }
    
    func handleLikeTap() {
        guard let item = viewItem else {
            return
        }
        
        performLikeAction(
            imageId: imageId,
            isLiked: !item.isLiked,
            currentLikeCount: item.likeCount,
            errorHandler: { [weak self] error in
                Task { @MainActor in
                    self?.coordinator.showErrorToast(
                        message: R.string.typicalTasks.favoritesDetailLikeErrorToastTitle("\(error)")
                    )
                }
            }
        )
    }
    
    private func updateViewItem(isLiked: Bool, likeCount: Int) {
        guard let currentItem = viewItem else {
            return
        }
        
        Task { @MainActor in
            viewItem = FavouritesDetailViewItem(
                id: currentItem.id,
                title: currentItem.title,
                imageUrl: currentItem.imageUrl,
                isLiked: isLiked,
                likeCount: likeCount
            )
        }
    }
    
    private func loadImage() {
        state = .loading
        
        Task { @MainActor in
            do {
                guard let model = try await postRepository.getPostDetail(id: imageId) else {
                    return
                }
                
                let likeState = await likeService.getLikeState(imageId: model.id)
                    ?? LikeService.LikeState(isLiked: model.isLiked, likeCount: model.likeCount)
                
                let viewItem = FavouritesDetailViewItem(
                    id: model.id,
                    title: model.title,
                    imageUrl: model.imageUrl,
                    isLiked: likeState.isLiked,
                    likeCount: likeState.likeCount
                )
                
                self.viewItem = viewItem
                state = .content
            } catch {
                state = .error
            }
        }
    }
}
