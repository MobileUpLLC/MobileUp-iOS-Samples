import SwiftUI

struct ChatInputBarView: View {
    @Binding var messageText: String
    
    let onSendMessageTapAction: Closure.Void
    let isDisabled: Bool
    
    var body: some View {
        HStack {
            TextField("Type a message", text: $messageText)
                .textFieldStyle(.roundedBorder)
            Button("Send") {
                onSendMessageTapAction()
            }
            .disabled(isDisabled)
        }
    }
}
