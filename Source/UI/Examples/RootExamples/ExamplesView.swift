import SwiftUI

struct ExamplesViewItem: Identifiable {
    let id = UUID()
    let title: String
    let action: Closure.Void
}

struct ExamplesView: View {
    @ObservedObject var viewModel: ExamplesViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(R.string.examples.examplesTitle())
                .font(UIFont.Heading.primary.asFont)
                .foregroundStyle(.black)
                .padding(.vertical, 20)
                .padding(.horizontal, 28)
            
            ExamplesContentView(items: viewModel.examples, onItemTap: viewModel.onItemTap(item:))
        }
        .background(.white)
    }
}

private struct ExamplesContentView: View {
    let items: [ExamplesViewItem]
    let onItemTap: Closure.Generic<ExamplesViewItem>
    
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

struct ExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        ExamplesView(
            viewModel: ExamplesViewModel(
                coordinator: ExamplesCoordinator()
            )
        )
    }
}
