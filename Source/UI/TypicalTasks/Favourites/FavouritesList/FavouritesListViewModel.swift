import Foundation

final class FavouritesListViewModel: PostLikeableViewModel {
    enum ViewState {
        case initial
        case loading
        case content
        case error
    }
    
    @Published private(set) var state: ViewState = .initial
    @Published var viewItems: [FavouritesListViewItem] = []
    
    private let coordinator: FavouritesListCoordinator
    let postRepository: PostRepository
    let likeService: LikeService
    
    init(
        coordinator: FavouritesListCoordinator,
        postRepository: PostRepository,
        likeService: LikeService
    ) {
        self.coordinator = coordinator
        self.postRepository = postRepository
        self.likeService = likeService
        
        setupLikePostUpdateAction()
    }
    
    func handleOnFirstAppear() {
        loadImages()
    }
    
    func handleLikeUpdate(with likeModel: LikeModel) {
        Task { @MainActor in
            if let index = viewItems.firstIndex(where: { $0.id == likeModel.imageId }) {
                viewItems[index] = FavouritesListViewItem(
                    id: viewItems[index].id,
                    title: viewItems[index].title,
                    imageUrl: viewItems[index].imageUrl,
                    isLiked: likeModel.isLike,
                    likeCount: likeModel.likeCount,
                    onTapAction: { [weak self] in
                        guard let self else {
                            return
                        }
                        
                        handlePostTap(postId: viewItems[index].id)
                    },
                    onLikeTapAction: { [weak self] id in self?.handleLikeTap(imageId: id) }
                )
            }
        }
    }
    
    func handlePostTap(postId: String) {
        coordinator.showFavouritesDetail(imageId: postId)
    }
    
    func handleLikeTap(imageId: String) {
        guard let item = viewItems.first(where: { $0.id == imageId }) else {
            return
        }
        
        performLikeAction(
            imageId: imageId,
            isLiked: !item.isLiked,
            currentLikeCount: item.likeCount,
            errorHandler: { [weak self] error in
                Task { @MainActor in
                    self?.coordinator.showErrorToast(message: "Не получилось обновить лайк: \(error)")
                }
            }
        )
    }
    
    private func loadImages() {
        state = .loading
        
        Task { @MainActor in
            do {
                let models = try await postRepository.getPosts()
                
                var viewItems: [FavouritesListViewItem] = []
                
                for model in models {
                    let likeState = await likeService.getLikeState(imageId: model.id)
                        ?? LikeService.LikeState(isLiked: model.isLiked, likeCount: model.likeCount)
                    
                    viewItems.append(
                        FavouritesListViewItem(
                            id: model.id,
                            title: model.title,
                            imageUrl: model.imageUrl,
                            isLiked: likeState.isLiked,
                            likeCount: likeState.likeCount,
                            onTapAction: { [weak self] in self?.handlePostTap(postId: model.id) },
                            onLikeTapAction: { [weak self] id in self?.handleLikeTap(imageId: id) }
                        )
                    )
                }
                
                self.viewItems = viewItems
                state = .content
            } catch {
                state = .error
            }
        }
    }
}
