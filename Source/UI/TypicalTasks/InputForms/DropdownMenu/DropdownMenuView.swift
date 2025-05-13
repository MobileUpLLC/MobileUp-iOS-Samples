import SwiftUI

struct DropdownMenuView: View {
    @Binding private var isFocused: Bool
    @Binding private var selectedItem: String
    
    private let title: String
    private let items: [String]
    private let onSelection: (String) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Text(title)
                        .font(getTitleFont())
                        .foregroundStyle(.black)
                    Spacer(minLength: 8)
                    getIcon()
                }
                .padding(.top, title.isEmpty ? 30 : 14)
                .padding(.horizontal, 12)
                if selectedItem.isEmpty == false {
                    HStack(spacing: 0) {
                        Text(selectedItem)
                            .font(UIFont.Body.primary.asFont)
                            .foregroundStyle(.black)
                        Spacer(minLength: 8)
                    }
                    .padding(.top, selectedItem.isEmpty ? 30 : 14)
                    .padding([.horizontal, .bottom], 12)
                }
            }
            .frame(height: 80)
            .background(.white)
            .roundedCorner(16, corners: .allCorners)
            .defaultStroke(cornerRadius: 16, lineWidth: 1, color: .black)
            .zIndex(1)
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.1)) {
                    isFocused.toggle()
                }
            }
            if isFocused {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                            .font(UIFont.Body.primary.asFont)
                            .foregroundStyle(.black)
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.15)) {
                                    selectedItem = item
                                    isFocused = false
                                }
                                onSelection(item)
                            }
                    }
                }
                .padding(.top, 24)
                .roundedCorner(16, corners: .allCorners)
                .defaultStroke(cornerRadius: 16, lineWidth: 1, color: .black)
                .padding(.top, -24)
            }
        }
    }
    
    init(
        isFocused: Binding<Bool>,
        selectedItem: Binding<String>,
        title: String,
        items: [String],
        onSelection: @escaping (String) -> Void
    ) {
        self._isFocused = isFocused
        self._selectedItem = selectedItem
        self.title = title
        self.items = items
        self.onSelection = onSelection
    }
    private func getTitleFont() -> Font {
        return selectedItem.isEmpty ? UIFont.Body.primary.asFont : UIFont.Heading.small.asFont
    }
    
    private func getIcon() -> Image {
        return isFocused ? Image(systemName: "chevron.up") : Image(systemName: "chevron.down")
    }
}

#Preview {
    DropdownMenuView(
        isFocused: .constant(false),
        selectedItem: .constant("text"),
        title: "title",
        items: ["item 1", "item 2", "item 3"],
        onSelection: { _ in }
    )
}
