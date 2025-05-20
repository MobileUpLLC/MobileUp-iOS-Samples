import SwiftUI

struct VideoView: View {
    private enum Constants {
        static let urlString = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    }
    
    var body: some View {
        VStack {
            if let url = URL(string: Constants.urlString) {
                VideoPlayerView(url: url)
                    .frame(height: UIScreen.main.bounds.width * 9 / 16)
            } else {
                Text("Invalid url")
            }
        }
        .background(Color.white)
    }
}

#Preview {
    VideoView()
}
