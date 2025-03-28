import SwiftUI

struct MultipleBottomSheetExampleView: View {
    @ObservedObject var viewModel: MultipleBottomSheetExampleViewModel

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            Button("Show green sheet") {
                viewModel.bottomSheet = .greenSheet
            }
        }
        .sheet(item: $viewModel.bottomSheet) { sheet in
            switch sheet {
            case .greenSheet:
                ZStack {
                    Color.green
                        .opacity(0.5)
                        .ignoresSafeArea()
                    Button("Show blue sheet") {
                        viewModel.onShowBlueSheetButtonTapped()
                    }
                }
                .presentationDetents([.medium])
            case .blueSheet:
                ZStack {
                    Color.blue
                        .opacity(0.5)
                        .ignoresSafeArea()
                    Button("Show green sheet") {
                        viewModel.onShowGreenSheetButtonTapped()
                    }
                }
                .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    MultipleBottomSheetExampleView(viewModel: .init(coordinator: .init()))
}
