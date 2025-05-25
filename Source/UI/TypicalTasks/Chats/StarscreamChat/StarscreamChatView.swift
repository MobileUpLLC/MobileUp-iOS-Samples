import SwiftUI

struct StarscreamChatView: View {
    @ObservedObject var viewModel: StarscreamChatViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(viewModel.messages) { message in
                        ChatMessageCellView(message: message)
                    }
                    .loadable(isLoading: viewModel.isLoading)
                    .onChange(of: viewModel.messages) { newMessages in
                        if let lastMessageId = newMessages.last?.id {
                            withAnimation {
                                proxy.scrollTo(lastMessageId, anchor: .bottom)
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            ChatInputBarView(
                messageText: $viewModel.messageText,
                onSendMessageTapAction: viewModel.handleSendMessageButtonTap,
                isDisabled: viewModel.messageText.isEmpty
            )
            .padding()
        }
        .padding(.horizontal, 20)
        .onFirstAppear {
            viewModel.handleFirstAppear()
        }
    }
}
