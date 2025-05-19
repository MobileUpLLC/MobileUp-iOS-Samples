import SwiftUI
import PhotosUI

struct CapturePhotoView: View {
    @State private var showCamera = false
    @State private var capturedImage: UIImage?
    @State private var imageData: Data?
    
    var body: some View {
        VStack(spacing: 20) {
            if let image = capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("There is no photo yet")
            }
            Button {
                showCamera.toggle()
            } label: {
                Text("Take photo")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .fullScreenCover(isPresented: $showCamera) {
            CapturePhotoPreview(image: $capturedImage, imageData: $imageData)
                .background(Color.black)
        }
    }
}
