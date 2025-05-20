import AVFoundation
import SwiftUI

struct CaptureVideoView: View {
    @StateObject private var recorder = CaptureVideoRecorder()
    
    var body: some View {
        CaptureVideoPreview(session: recorder.session)
            .overlay {
                VStack {
                    Spacer()
                    Button {
                        recorder.isRecording ? recorder.stopRecording() : recorder.startRecording()
                    } label: {
                        Text(recorder.isRecording ? "Stop Recording" : "Start Recording")
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
                .animation(.default, value: recorder.isRecording)
            }
    }
}
