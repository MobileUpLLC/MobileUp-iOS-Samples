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
                Text(R.string.typicalTasks.capturePhotoErrorTitle())
            }
            Button {
                showCamera.toggle()
            } label: {
                Text(R.string.typicalTasks.capturePhotoTakeButtonTitle())
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
