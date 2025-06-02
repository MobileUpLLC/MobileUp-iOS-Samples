import SwiftUI

struct ImageCarouselView: View {
    let imageNames: [String] = [
        "paperplane",
        "paperplane.fill",
        "exclamationmark.triangle",
        "car",
        "car.fill"
    ]
    
    @State private var currentIndex = 0
    @State private var isFullscreen = false
    
    var body: some View {
        VStack {
            Spacer()
            TabView(selection: $currentIndex) {
                ForEach(imageNames.indices, id: \.self) { index in
                    Image(systemName: imageNames[index])
                        .resizable()
                        .scaledToFit()
                        .tag(index)
                        .onTapGesture {
                            isFullscreen = true
                        }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            Spacer()
            HStack(spacing: 8) {
                ForEach(imageNames.indices, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.black : Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                        .scaleEffect(index == currentIndex ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: currentIndex)
                }
            }
        }
        .background(Color.blue.opacity(0.3))
        .fullScreenCover(isPresented: $isFullscreen) {
            FullscreenView(imageName: imageNames[currentIndex])
                .background(Color.green.opacity(0.3))
        }
    }
}

private struct FullscreenView: View {
    @Environment(\.dismiss) var dismiss
    
    let imageName: String
    
    var body: some View {
        VStack(alignment: .trailing) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
            }
            .tint(.black)
            .padding(.horizontal)
            .buttonStyle(.borderedProminent)
            ZoomView {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

#Preview {
    ImageCarouselView()
}
