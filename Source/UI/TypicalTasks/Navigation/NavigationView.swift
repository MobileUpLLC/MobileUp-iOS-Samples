import SwiftUI

struct NavigationViewItem: Identifiable {
    let id = UUID()
    let title: String
    let action: Closure.Void
}

struct NavigationView: View {
    @ObservedObject var viewModel: NavigationViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(R.string.typicalTasks.typicalTasksNavigation())
                .font(UIFont.Heading.primary.asFont)
                .foregroundStyle(.black)
                .padding(.vertical, 20)
                .padding(.horizontal, 28)
            if let text = viewModel.textFromNextModule {
                Text("Text from next module:")
                    .font(.headline)
                    .padding(.horizontal, 16)
                Text(text)
                    .font(.subheadline)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 16)
            }
            NavigationContentView(items: viewModel.navigationItems)
        }
        .background(.white)
        .shareSheet(isShareSheetShown: $viewModel.isShareSheetShown, shareSheetItems: viewModel.shareSheetItems)
        .sheet(isPresented: $viewModel.isBottomSheetPresented) {
            GreenBottomSheetView(showSkeletonButtonHandler: viewModel.onShowSkeletonButtonTapped)
                .enablePresentationBackgroundInteraction(upThrough: .medium)
                .presentationDetents([.fraction(0.5)])
        }
        .sheet(isPresented: $viewModel.isScrollableBottomSheetPresented) {
            BottomSheetWithScrollExampleView()
        }
        .alert(
            R.string.navigation.alertTitle(),
            isPresented: $viewModel.isAlertPresented,
            actions: {
                Button(R.string.common.okButtonTitle()) { viewModel.onAlertButtonTapped() }
            },
            message: { Text(R.string.navigation.alertMessage()) }
        )
    }
}

private struct NavigationContentView: View {
    let items: [NavigationViewItem]
    
    private let columns: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(items) { item in
                    NavigationCellView(text: item.title)
                        .contentShape(Rectangle())
                        .onTapGesture { item.action() }
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
