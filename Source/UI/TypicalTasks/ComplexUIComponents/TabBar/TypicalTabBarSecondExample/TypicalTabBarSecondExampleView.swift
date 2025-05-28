import SwiftUI

struct TypicalTabBarSecondExampleView: View {
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.blue.opacity(0.5))
            .ignoresSafeArea()
            .background(.white)
    }
}

#Preview {
    TypicalTabBarFirstExampleView()
}
