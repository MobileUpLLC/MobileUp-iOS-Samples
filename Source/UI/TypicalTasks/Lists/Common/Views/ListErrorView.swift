import SwiftUI

struct ListErrorView: View {
    var body: some View {
        Image(systemName: "exclamationmark.triangle")
            .font(.system(size: 100))
            .foregroundStyle(.yellow)
    }
}

#Preview {
    ListErrorView()
}
