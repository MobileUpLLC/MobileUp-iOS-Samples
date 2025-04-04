import SwiftUI

struct BottomSheetWithScrollExampleView: View {
    private let items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    var body: some View {
            VStack(spacing: .zero) {
                VStack(spacing: 8) {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                            .font(.title)
                            .padding(30)
                    }
                }
                .wrappedInScrollView(isScrollable: true)
            }
        }
}

#Preview {
    BottomSheetWithScrollExampleView()
}
