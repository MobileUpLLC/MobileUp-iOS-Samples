import Foundation

final class FavouritesDetailViewModel: ObservableObject, ImageLikeMakableViewModel {
    enum ViewState {
        case initial
        case loading
        case content
        case error
    }
    
    @Published private(set) var state: ViewState = .initial
    @Published var viewItem: FavouritesDetailViewItem?
    
    let publicationRepository: PublicationRepository
    private let coordinator: FavouritesDetailCoordinator
    private let imageId: String
    
    init(
        coordinator: FavouritesDetailCoordinator,
        publicationRepository: PublicationRepository,
        imageId: String
    ) {
        self.coordinator = coordinator
        self.publicationRepository = publicationRepository
        self.imageId = imageId
        loadImage()
        
        publicationRepository.onLikePostUpdate = { [weak self] likeModel in
            self?.handleLikeUpdate(with: likeModel)
        }
    }
    
    func handleLikeUpdate(with likeModel: LikeModel) {
        guard imageId == likeModel.imageId else {
            return
        }
        
        updateViewItem(isLiked: likeModel.isLike, likeCount: likeModel.likeCount)
    }
    
    func handleLikeTap() {
        guard let item = viewItem else { return }
        
        performLikeAction(
            imageId: imageId,
            isLike: !item.isLiked,
            currentLikeCount: item.likeCount,
            errorHandler: { [weak self] error in
                self?.state = .error
            }
        )
    }
    
    func updateViewItem(isLiked: Bool, likeCount: Int) {
        guard let currentItem = viewItem else {
            return
        }
        
        viewItem = FavouritesDetailViewItem(
            id: currentItem.id,
            title: currentItem.title,
            imageUrl: currentItem.imageUrl,
            isLiked: isLiked,
            likeCount: likeCount
        )
    }
    
    private func loadImage() {
        state = .loading
        Perform { [weak self] in
            guard let self else { return }
            // Имитация загрузки данных
            guard let model = publicationRepository.getPostDetail(id: imageId) else {
                return
            }
            
            let viewItem = FavouritesDetailViewItem(
                id: model.id,
                title: model.title,
                imageUrl: model.imageUrl,
                isLiked: LikeService.getLikeState(imageId: model.id)?.isLiked ?? model.isLiked,
                likeCount: LikeService.getLikeState(imageId: model.id)?.likeCount ?? model.likeCount
            )
            onMain {
                self.viewItem = viewItem
                self.state = .content
            }
        } onError: { [weak self] _ in
            onMain {
                self?.state = .error
            }
        }
    }
}
