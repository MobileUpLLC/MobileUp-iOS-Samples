import SwiftUI

struct BottomSheetWithScrollExampleView: View {
    @ObservedObject var viewModel: BottomSheetWithScrollExampleViewModel
    
    var body: some View {
            VStack(spacing: .zero) {
                VStack(spacing: 8) {
                    ForEach(viewModel.scrollableBottomSheetItems, id: \.self) { item in
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
    BottomSheetWithScrollExampleView(
        viewModel: BottomSheetWithScrollExampleViewModel(
            coordinator: BottomSheetWithScrollExampleCoordinator()
        )
    )
}
