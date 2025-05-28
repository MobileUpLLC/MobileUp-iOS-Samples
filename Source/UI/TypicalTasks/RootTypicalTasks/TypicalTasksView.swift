import SwiftUI

struct TypicalTasksViewItem: Identifiable {
    let id = UUID()
    let title: String
    let action: Closure.Void
}

struct TypicalTasksView: View {
    @ObservedObject var viewModel: TypicalTasksViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(R.string.typicalTasks.typicalTasksTitle())
                .font(UIFont.Heading.primary.asFont)
                .foregroundStyle(.black)
                .padding(.vertical, 20)
                .padding(.horizontal, 28)
            
            TypicalTasksContentView(items: viewModel.typicalTasks, onItemTap: viewModel.onItemTap(item:))
        }
        .background(.white)
        .alert(
            String.empty,
            isPresented: $viewModel.isDeleteAlertPresented,
            actions: {
                Button(R.string.examples.alertCancelButtonTitle(), role: .cancel) { }
                Button(R.string.examples.alertLogoutButtonTitle(), role: .destructive) {
                    viewModel.onDeleteAlertLogoutButtonTapped()
                }
            },
            message: { Text(R.string.examples.secondAlertMessage()) }
        )
        .alert(
            String.empty,
            isPresented: $viewModel.isSuccessAuthAlertPresented,
            actions: {
                Button(R.string.examples.alertCancelButtonTitle(), role: .cancel) { }
                Button(R.string.examples.alertLogoutButtonTitle(), role: .destructive) {
                    viewModel.clearUserData()
                }
            },
            message: { Text(R.string.typicalTasks.typicalTasksAuthorizedMessage()) }
        )
        .alert(
            String.empty,
            isPresented: $viewModel.isNotAuthAlertPresented,
            actions: {
                Button(R.string.examples.alertCancelButtonTitle(), role: .cancel) { }
                Button(R.string.examples.alertLogoutButtonTitle(), role: .destructive) {
                    viewModel.openEntranceModule()
                }
            },
            message: { Text(R.string.typicalTasks.typicalTasksNotAuthorizedMessage()) }
        )
    }
}

private struct TypicalTasksContentView: View {
    let items: [TypicalTasksViewItem]
    let onItemTap: Closure.Generic<TypicalTasksViewItem>
    
    private let columns: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(items) { item in
                    ExamplesCellView(text: item.title)
                        .contentShape(Rectangle())
                        .onTapGesture { onItemTap(item) }
                }
            }
        }
    }
}

private struct ExamplesCellView: View {
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
    TypicalTasksView(
        viewModel: TypicalTasksViewModel(
            coordinator: TypicalTasksCoordinator(), authRepository: AuthRepository()
        )
    )
}
