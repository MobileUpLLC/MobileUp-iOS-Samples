import SwiftUI

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
                                viewModel.handlePostTap(postId: item.id)
                            }
                    }
                }
                .navigationTitle("Posts")
            case .error:
                Text("Error loading posts")
            }
        }
        .onAppear { viewModel.handleOnAppear() }
    }
}

private struct FavouritesListCellView: View {
    @Binding var viewItem: FavouritesListViewItem
    
    var body: some View {
        HStack {
            ImageView(imageLink: viewItem.imageUrl)
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
