import SwiftUI

struct ComplexUIComponentsView: View {
    @ObservedObject var viewModel: ComplexUIComponentsViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(R.string.typicalTasks.imageCarouselTitle(), destination: ImageCarouselView())
                NavigationLink(R.string.typicalTasks.calendarTitle(), destination: CalendarView())
                NavigationLink(
                    R.string.typicalTasks.collapsingViewTitle(),
                    destination: CollapsingView(onlyFromTop: true)
                )
                Button(R.string.typicalTasks.tabbarButtonTitle()) {
                    viewModel.showTypicalTabBar()
                }
                Button(R.string.typicalTasks.closeButtonTitle()) {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    ComplexUIComponentsView(
        viewModel: ComplexUIComponentsViewModel(
            coordinator: ComplexUIComponentsCoordinator(
                networkService: .init()
            )
        )
    )
}
