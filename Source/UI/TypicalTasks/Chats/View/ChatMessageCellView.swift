import SwiftUI

struct ChatMessageCellView: View {
    let message: Message
    
    var body: some View {
        Text(message.text)
            .padding()
            .background(message.senderId == "user" ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
            .cornerRadius(10)
            .frame(maxWidth: .infinity, alignment: message.senderId == "user" ? .trailing : .leading)
            .id(message.id)
    }
}
