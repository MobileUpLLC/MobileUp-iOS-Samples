import SwiftUI

extension View {
    func shareSheet(
        isShareSheetShown: Binding<Bool>,
        shareSheetItems: [Any],
        activities: [UIActivity]? = nil
    ) -> some View {
        modifier(
            ShareSheetModifer(isShareSheetShown: isShareSheetShown, items: shareSheetItems, activities: activities)
        )
    }
}

struct ShareSheetModifer: ViewModifier {
    @Binding var isShareSheetShown: Bool
    
    let items: [Any]
    let activities: [UIActivity]?
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isShareSheetShown) {
                ShareSheetView(items: items, activities: activities)
                    .ignoresSafeArea()
                    .presentationDetents([.medium])
            }
    }
}
