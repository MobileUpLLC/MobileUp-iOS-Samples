import SwiftUI

struct VideoView: View {
    private enum Constants {
        static let urlString = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        static let videoPlayerHeight = UIScreen.main.bounds.width * 9 / 16
    }
    
    var body: some View {
        VStack {
            if let url = URL(string: Constants.urlString) {
                VideoPlayerView(url: url)
                    .frame(height: Constants.videoPlayerHeight)
            } else {
                Text(R.string.typicalTasks.videoPlayerUrlErrorTitle())
            }
        }
        .background(.white)
    }
}

#Preview {
    VideoView()
}
