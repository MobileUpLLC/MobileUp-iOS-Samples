import SwiftUI

struct ComplexUIComponentsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("ImageCarousel", destination: ImageCarouselView())
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
