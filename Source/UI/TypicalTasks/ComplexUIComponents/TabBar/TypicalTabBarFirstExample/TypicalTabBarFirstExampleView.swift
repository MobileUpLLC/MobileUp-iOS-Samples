import SwiftUI

struct TypicalTabBarFirstExampleView: View {
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.red.opacity(0.5))
            .ignoresSafeArea()
            .background(.white)
    }
}

#Preview {
    TypicalTabBarFirstExampleView()
}
