import AVFoundation
import SwiftUI

struct ScanCodeView: UIViewRepresentable {
    let containerView = UIView()
    let handleScanCompletion: Closure.String
    
    func makeUIView(context: Context) -> UIView {
        containerView.frame = UIScreen.main.bounds
        context.coordinator.createLayer()
        
        if let previewLayer = context.coordinator.videoPreviewLayer {
            previewLayer.frame = containerView.layer.bounds
            containerView.layer.addSublayer(previewLayer)
        }
        
        return containerView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(handleScanCompletion: handleScanCompletion)
    }
    
    static func dismantleUIView(_ uiView: UIView, coordinator: Coordinator) {
        coordinator.captureSession.stopRunning()
    }
    
    final class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        private enum Constants {
            static let scanRestartDelay: TimeInterval = 5
        }
        
        var captureSession = AVCaptureSession()
        var videoPreviewLayer: AVCaptureVideoPreviewLayer?
        
        private let handleScanCompletion: Closure.String
        
        init(handleScanCompletion: @escaping Closure.String) {
            self.handleScanCompletion = handleScanCompletion
        }
        
        func createLayer() {
            guard
                let captureDevice = AVCaptureDevice.default(for: .video),
                let videoInput = try? AVCaptureDeviceInput(device: captureDevice)
            else {
                return
            }
            
            captureSession.addInput(videoInput)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [.qr, .ean13, .code128]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            
            startScanning()
        }
        
        func metadataOutput(
            _ output: AVCaptureMetadataOutput,
            didOutput metadataObjects: [AVMetadataObject],
            from connection: AVCaptureConnection
        ) {
            if
                metadataObjects.isEmpty == false,
                let metadataObj = metadataObjects[.zero] as? AVMetadataMachineReadableCodeObject,
                metadataObj.type == AVMetadataObject.ObjectType.qr
                || metadataObj.type == AVMetadataObject.ObjectType.code128
                || metadataObj.type == AVMetadataObject.ObjectType.ean13,
                let result = metadataObj.stringValue
            {
                captureSession.stopRunning()
                handleScanCompletion(result)
                restartScanningAfterDelay()
            }
        }
        
        private func startScanning() {
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
        }
        
        private func restartScanningAfterDelay() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.scanRestartDelay) {
                self.startScanning()
            }
        }
    }
}
