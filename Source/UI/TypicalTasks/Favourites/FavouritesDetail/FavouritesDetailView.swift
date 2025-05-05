import SwiftUI
import Kingfisher

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
                    KFImage(URL(string: viewItem.imageUrl))
                        .placeholder { ProgressView() }
                        .resizable()
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
                        Text("Likes: \(viewItem.likeCount)")
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .navigationTitle("Image Detail")
            } else {
                EmptyView()
            }
        case .error:
            Text("Error loading image")
        }
    }
}
