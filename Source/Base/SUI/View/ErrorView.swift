import SwiftUI

struct ErrorView: View {
    let onRetry: Closure.Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 150))
                .opacity(0.2)
            Text(R.string.common.errorStateTitle())
                .font(UIFont.Heading.secondary.asFont)
            Text(R.string.common.errorStateSubtitle())
                .font(UIFont.Heading.medium.asFont)
            Button(action: onRetry) {
                Text(R.string.common.errorStateButtonTitle())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(30)
        }
        .foregroundStyle(.gray)
    }
}

#Preview {
    ErrorView(onRetry: {})
}
