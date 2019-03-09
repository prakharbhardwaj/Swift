//
//  AVCodeReader.swift
//  AVFoundationQRcode
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import AVFoundation

class AVCodeReader: NSObject, CodeReader {
    private(set) var videoPreview = CALayer()
    private var captureSession: AVCaptureSession?
    private var completion: ((CodeReadResult) -> Void)?
    
    override init() {
        super.init()
        
        guard let captureVideoDevice = AVCaptureDevice.default(for: .video), let deviceInput = try? AVCaptureDeviceInput(device: captureVideoDevice) else {
            return
        }
        
        captureSession = AVCaptureSession()
        guard let captureSession = captureSession else { return }
        
        //input
        captureSession.addInput(deviceInput)
        //output
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue(label: "com.example.QRCode.metadata", attributes: []))
        //interprets qr codes only
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        //preview
        let captureVideoPreview = AVCaptureVideoPreviewLayer(session: captureSession)
        captureVideoPreview.videoGravity = .resizeAspectFill
        self.videoPreview = captureVideoPreview
    }
    
    func startReading(completion: @escaping (CodeReadResult) -> Void) {
        //the current only reason a session would be null is if camera is not available
        guard let captureSession = captureSession else {
            completion(.failure(.noCameraAvailable))
            return
        }
        self.completion = completion
        captureSession.startRunning()
    }
    
    func stopReading() {
        captureSession?.stopRunning()
    }
}

extension AVCodeReader: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let readableCode = metadataObjects.first as? AVMetadataMachineReadableCodeObject, let elemento = readableCode.stringValue else {
            return
        }
        
        completion?(.success(elemento))
    }
}
