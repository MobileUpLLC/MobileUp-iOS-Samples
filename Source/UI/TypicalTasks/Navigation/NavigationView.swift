import SwiftUI

struct NavigationViewItem: Identifiable {
    let id = UUID()
    let title: String
    let action: Closure.Void
}

struct NavigationView: View {
    @ObservedObject var viewModel: NavigationViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(R.string.typicalTasks.typicalTasksNavigation())
                .font(UIFont.Heading.primary.asFont)
                .foregroundStyle(.black)
                .padding(.vertical, 20)
                .padding(.horizontal, 28)
            
            NavigationContentView(items: viewModel.navigationItems, onItemTap: viewModel.onItemTap(item:))
            if let text = viewModel.textFromNextModule {
                Text("Text from next module:")
                Text(text)
            }
        }
        .background(.white)
        .shareSheet(isShareSheetShown: $viewModel.isShareSheetShown, shareSheetItems: viewModel.shareSheetItems)
        .sheet(isPresented: $viewModel.isBottomSheetPresented) {
            GreenBottomSheetView(showSkeletonButtonHandler: viewModel.onShowSkeletonButtonTapped)
                .enablePresentationBackgroundInteraction(upThrough: .medium)
                .presentationDetents([.fraction(0.5)])
        }
        .sheet(isPresented: $viewModel.isScrollableBottomSheetPresented) {
            BottomSheetWithScrollExampleView(
                viewModel: BottomSheetWithScrollExampleViewModel(
                    coordinator: BottomSheetWithScrollExampleCoordinator()
                )
            )
        }
        .alert(
            R.string.navigation.alertTitle(),
            isPresented: $viewModel.isAlertPresented,
            actions: {
                Button("OK") { viewModel.onAlertButtonTapped() }
            },
            message: { Text(R.string.navigation.alertMessage()) }
        )
    }
}

private struct NavigationContentView: View {
    let items: [NavigationViewItem]
    let onItemTap: Closure.Generic<NavigationViewItem>
    
    private let columns: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(items) { item in
                    NavigationCellView(text: item.title)
                        .contentShape(Rectangle())
                        .onTapGesture { onItemTap(item) }
                }
            }
        }
    }
}

private struct NavigationCellView: View {
    let text: String
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                Text(text)
                    .font(UIFont.Heading.medium.asFont)
                    .foregroundStyle(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .padding(.bottom, 10)
            
            Rectangle()
                .fill(.gray.opacity(0.5))
                .frame(maxWidth: .infinity)
                .frame(height: 0.3)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    NavigationView(
        viewModel: NavigationViewModel(
            coordinator: NavigationCoordinator(),
            navigationRepository: NavigationRepository()
        )
    )
}
