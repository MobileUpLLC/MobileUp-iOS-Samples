import SwiftUI

struct MultimediaView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(R.string.typicalTasks.capturePhotoTitle(), destination: CapturePhotoView())
                NavigationLink(R.string.typicalTasks.captureVideoTitle(), destination: CaptureVideoView())
                NavigationLink(
                    R.string.typicalTasks.scanCodeTitle(),
                    destination: ScanCodeView(handleScanCompletion: { value in print(value) })
                )
                NavigationLink(R.string.typicalTasks.videoPlayerTitle(), destination: VideoView())
                NavigationLink(R.string.typicalTasks.cropImageTitle(), destination: CropImageView())
            }
        }
    }
}
