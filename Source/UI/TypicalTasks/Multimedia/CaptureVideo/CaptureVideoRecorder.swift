import AVFoundation
import Photos

final class CaptureVideoRecorder: NSObject, ObservableObject {
    @Published var isRecording = false
    let session = AVCaptureSession()
    
    private let movieOutput = AVCaptureMovieFileOutput()
    
    override init() {
        super.init()
        
        addAudioInput()
        addVideoInput()
        
        if session.canAddOutput(movieOutput) {
            session.addOutput(movieOutput)
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.session.startRunning()
        }
    }
    
    func startRecording() {
        guard
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent("video.mp4")
        else {
            return
        }
        
        if movieOutput.isRecording == false {
            if FileManager.default.fileExists(atPath: url.path) {
                try? FileManager.default.removeItem(at: url)
            }
            
            movieOutput.startRecording(to: url, recordingDelegate: self)
            isRecording = true
        }
    }
    
    func stopRecording() {
        if movieOutput.isRecording {
            movieOutput.stopRecording()
            isRecording = false
        }
    }
    
    private func addAudioInput() {
        guard
            let device = AVCaptureDevice.default(for: .audio),
            let input = try? AVCaptureDeviceInput(device: device),
            session.canAddInput(input)
        else {
            return
        }
        
        session.addInput(input)
    }
    
    private func addVideoInput() {
        guard
            let device = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: device),
            session.canAddInput(input)
        else {
            return
        }
        
        session.addInput(input)
    }
}

extension CaptureVideoRecorder: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(
        _ output: AVCaptureFileOutput,
        didFinishRecordingTo outputFileURL: URL,
        from connections: [AVCaptureConnection],
        error: Error?
    ) {
        if let error = error {
            print("Error recording: \(error.localizedDescription)")
            
            return
        }
        
        // swiftlint:disable opening_brace
        PHPhotoLibrary.shared().performChanges(
            { PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputFileURL) },
            completionHandler: { [weak self] saved, error in self?.handleSaveResult(saved, error) }
        )
        // swiftlint:enable opening_brace
    }
    
    private func handleSaveResult(_ saved: Bool, _ error: (any Error)?) {
        if saved {
            print("Successfully saved video to Photos.")
        } else if let error = error {
            print("Error saving video to Photos: \(error.localizedDescription)")
        }
    }
}
