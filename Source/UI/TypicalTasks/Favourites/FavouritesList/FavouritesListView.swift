import SwiftUI
import Kingfisher

struct FavouritesListViewItem: Identifiable {
    let id: String
    let title: String
    let imageUrl: String
    let isLiked: Bool
    let likeCount: Int
    let onTapAction: Closure.Void
    let onLikeTapAction: Closure.String
}

struct FavouritesListView: View {
    @ObservedObject var viewModel: FavouritesListViewModel
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .initial, .loading:
                ProgressView()
            case .content:
                List {
                    ForEach($viewModel.viewItems, id: \.id) { item in
                        FavouritesListCellView(viewItem: item)
                            .onTapGesture {
                                viewModel.handleImageTap(imageId: item.id)
                            }
                    }
                }
                .navigationTitle("Images")
            case .error:
                Text("Error loading images")
            }
        }
        .onFirstAppear { viewModel.handleOnFirstAppear() }
    }
}

struct FavouritesListCellView: View {
    @Binding var viewItem: FavouritesListViewItem
    
    var body: some View {
        HStack {
            KFImage(URL(string: viewItem.imageUrl))
                .placeholder { ProgressView() }
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(viewItem.title)
                Text("Likes: \(viewItem.likeCount)")
            }
            Spacer()
            Image(systemName: viewItem.isLiked ? "heart.fill" : "heart")
                .foregroundColor(viewItem.isLiked ? .red : .gray)
                .onTapGesture {
                    viewItem.onLikeTapAction(viewItem.id)
                }
        }
        .onTapGesture {
            viewItem.onTapAction()
        }
    }
}
