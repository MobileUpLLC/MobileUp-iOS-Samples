import SwiftUI
import SwiftyCrop

struct CropImageView: View {
    @State private var showImageCropper = false
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack {
            if let selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Button("Crop downloaded image") {
                selectedImage = R.image.image.asUIImage
                showImageCropper.toggle()
            }
        }
        .fullScreenCover(isPresented: $showImageCropper) {
            if let selectedImage {
                SwiftyCropView(
                    imageToCrop: selectedImage,
                    maskShape: .square
                ) { croppedImage in
                    self.selectedImage = croppedImage
                }
            }
        }
    }
}

#Preview {
    CropImageView()
}
