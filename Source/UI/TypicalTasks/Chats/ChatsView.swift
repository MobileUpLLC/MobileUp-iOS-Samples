import SwiftUI

struct ChatsView: View {
    @ObservedObject var viewModel: ChatsViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(viewModel.messages) { message in
                        Text(message.text)
                            .padding()
                            .background(message.senderId == "user" ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: message.senderId == "user" ? .trailing : .leading)
                            .id(message.id)
                    }
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
            HStack {
                TextField("Type a message", text: $viewModel.messageText)
                    .textFieldStyle(.roundedBorder)
                Button("Send") {
                    viewModel.handleSendMessageButtonTap()
                }
                .disabled(viewModel.messageText.isEmpty)
            }
            .padding()
        }
        .padding(.horizontal, 20)
        .onFirstAppear {
            viewModel.handleFirstAppear()
        }
    }
}
