import AVFoundation
import SwiftUI

struct CaptureVideoView: View {
    @StateObject private var recorder = CaptureVideoRecorder()
    
    var body: some View {
        ZStack {
            CaptureVideoPreview(session: recorder.session)
            VStack {
                Spacer()
                Button {
                    recorder.isRecording ? recorder.stopRecording() : recorder.startRecording()
                } label: {
                    Text("Start Recording")
                        .tint(.white)
                        .padding()
                        .background(recorder.isRecording ? .red : .blue)
                        .cornerRadius(8)
                }
                if recorder.isRecording {
                    Text("Recording...")
                        .foregroundColor(.red)
                }
            }
        }
        .animation(.default, value: recorder.isRecording)
    }
}
