import SwiftUI

struct ComplexUIComponentsView: View {
    @ObservedObject var viewModel: ComplexUIComponentsViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("ImageCarousel", destination: ImageCarouselView())
                NavigationLink("Calendar", destination: CalendarView())
                NavigationLink("Collapsing View", destination: CollapsingView(onlyFromTop: true))
                Button("TabBar") {
                    viewModel.showTypicalTabBar()
                }
                Button("Close") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    ComplexUIComponentsView(viewModel: ComplexUIComponentsViewModel(coordinator: ComplexUIComponentsCoordinator()))
}
