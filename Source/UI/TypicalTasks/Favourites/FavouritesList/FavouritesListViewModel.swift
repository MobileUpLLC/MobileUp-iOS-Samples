import Foundation

final class FavouritesListViewModel: ObservableObject, ImageLikeMakableViewModel {
    enum ViewState {
        case initial
        case loading
        case content
        case error
    }
    
    @Published private(set) var state: ViewState = .initial
    @Published var viewItems: [FavouritesListViewItem] = []
    
    private let coordinator: FavouritesListCoordinator
    let publicationRepository: PublicationRepository
    
    init(
        coordinator: FavouritesListCoordinator,
        publicationRepository: PublicationRepository
    ) {
        self.coordinator = coordinator
        self.publicationRepository = publicationRepository
        
        publicationRepository.onLikePostUpdate = { [weak self] likeModel in
            self?.handleLikeUpdate(with: likeModel)
        }
    }
    
    func handleOnFirstAppear() {
        loadImages()
    }
    
    func handleLikeUpdate(with likeModel: LikeModel) {
        updateViewItem(with: likeModel)
    }
    
    func handleImageTap(imageId: String) {
        coordinator.showFavouritesDetail(imageId: imageId)
    }
    
    func handleLikeTap(imageId: String) {
        guard let item = viewItems.first(where: { $0.id == imageId }) else {
            return
        }
        
        performLikeAction(
            imageId: imageId,
            isLike: !item.isLiked,
            currentLikeCount: item.likeCount,
            errorHandler: { [weak self] error in
                self?.coordinator.showErrorToast(message: "Не получилось обновить лайк")
            }
        )
    }
    
    private func loadImages() {
        state = .loading
        
        Perform { [weak self] in
            guard let self else {
                return
            }
            
            // Имитация загрузки данных
            let models = await publicationRepository.getPosts()
            
            let viewItems = models.map { [weak self] model in
                FavouritesListViewItem(
                    id: model.id,
                    title: model.title,
                    imageUrl: model.imageUrl,
                    isLiked: LikeService.getLikeState(imageId: model.id)?.isLiked ?? model.isLiked,
                    likeCount: LikeService.getLikeState(imageId: model.id)?.likeCount ?? model.likeCount,
                    onTapAction: { [weak self] in self?.handleImageTap(imageId: model.id) },
                    onLikeTapAction: { [weak self] id in self?.handleLikeTap(imageId: id) }
                )
            }
            onMain {
                self.viewItems = viewItems
                self.state = .content
            }
        } onError: { [weak self] _ in
            onMain {
                self?.state = .error
            }
        }
    }
    
    private func updateViewItem(with likeModel: LikeModel) {
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
                    
                    handleImageTap(imageId: viewItems[index].id)
                },
                onLikeTapAction: { [weak self] id in self?.handleLikeTap(imageId: id) }
            )
        }
    }
}
