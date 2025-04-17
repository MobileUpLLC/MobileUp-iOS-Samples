import SwiftUI

struct ComplexUIComponentsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("ImageCarousel", destination: ImageCarouselView())
                NavigationLink("Collapsing View", destination: CollapsingView(onlyFromTop: true))
                Button("Close") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    ComplexUIComponentsView()
}
