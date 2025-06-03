import SwiftUI

struct ChatsViewItem: Identifiable {
    let id = UUID()
    let title: String
    let action: Closure.Void
}

struct ChatsView: View {
    @ObservedObject var viewModel: ChatsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(R.string.typicalTasks.typicalTasksChats())
                .font(UIFont.Heading.primary.asFont)
                .foregroundStyle(.black)
                .padding(.vertical, 20)
                .padding(.horizontal, 28)
            ChatsContentView(items: viewModel.chatViewItems, onItemTap: viewModel.onItemTap(item:))
        }
    }
}

private struct ChatsContentView: View {
    let items: [ChatsViewItem]
    let onItemTap: Closure.Generic<ChatsViewItem>
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(items) { item in
                    ChatsCellView(text: item.title)
                        .contentShape(Rectangle())
                        .onTapGesture { onItemTap(item) }
                }
            }
        }
    }
}

private struct ChatsCellView: View {
    let text: String
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                Text(text)
                    .font(UIFont.Heading.medium.asFont)
                    .foregroundStyle(.black)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(.bottom, 10)
            Rectangle()
                .fill(.gray.opacity(0.5))
                .frame(maxWidth: .infinity)
                .frame(height: 0.3)
        }
        .padding(.horizontal, 16)
    }
}
