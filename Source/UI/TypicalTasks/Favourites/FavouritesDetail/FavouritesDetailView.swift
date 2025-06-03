import SwiftUI

struct FavouritesDetailViewItem: Identifiable {
    let id: String
    let title: String
    let imageUrl: String
    var isLiked: Bool
    var likeCount: Int
}

struct FavouritesDetailView: View {
    @ObservedObject var viewModel: FavouritesDetailViewModel
    
    var body: some View {
        switch viewModel.state {
        case .initial, .loading:
            ProgressView()
        case .content:
            if let viewItem = viewModel.viewItem {
                VStack {
                    ImageView(imageLink: viewItem.imageUrl)
                        .scaledToFit()
                        .frame(maxHeight: 300)
                    Text(viewItem.title)
                        .font(.title)
                    HStack {
                        Button {
                            viewModel.handleLikeTap()
                        } label: {
                            Image(systemName: viewItem.isLiked ? "heart.fill" : "heart")
                                .foregroundColor(viewItem.isLiked ? .red : .gray)
                        }
                        Text(R.string.typicalTasks.favoritesDetailLikeTitle(viewItem.likeCount))
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .navigationTitle(R.string.typicalTasks.favoritesDetailNavigationTitle())
            }
        case .error:
            Text(R.string.typicalTasks.favoritesDetailErrorTitle())
        }
    }
}
