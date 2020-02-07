//
//  CameraPreview.swift
//  photobooth
//
//  Created by Manuel on 2/5/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa
import AVFoundation

/// CameraPreview class delegate
protocol CameraPreviewDelegate: AnyObject {
    func didTakeSnapshot(_ snapshot: NSImage)
    func didEncounterError(_ error: Error)
}

/// NSView that holds an AVCaptureVideoPreviewLayer
class CameraPreview: NSView {

    // MARK: - UI Elements

    private lazy var cameraView: NSView = {
        let cameraView = NSView()
        cameraView.wantsLayer = true
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        return cameraView
    }()

    private var previewLayer = AVCaptureVideoPreviewLayer()

    // MARK: - Types

    enum CameraError: Error, LocalizedError {
        case captureDeviceNotFound

        public var errorDescription: String? {
            switch self {
                case .captureDeviceNotFound:
                    return "Camera not found"
            }
        }
    }

    // MARK: - Private Properties

    private lazy var captureSession: AVCaptureSession = {
        let captureSession = AVCaptureSession()
        captureSession.addOutput(captureImageOutput)
        return captureSession
    }()

    private lazy var captureDevice: AVCaptureDevice? = {
        let captureDevice = AVCaptureDevice.devices(for: AVMediaType.video).first
        return captureDevice
    }()

    private lazy var captureImageOutput: AVCaptureVideoDataOutput = {
        let captureImageOutput = AVCaptureVideoDataOutput()
        captureImageOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        captureImageOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        return captureImageOutput
    }()

    /// Returns true if image is flipped, defaults to true
    private(set) var isMirrored: Bool = true

    /// Toggled at takeSnapshot() and AVCaptureVideoDataOutputSampleBufferDelegate
    private var shouldCaptureSnapshot: Bool = false

    // MARK: - Public Properties

    weak var delegate: CameraPreviewDelegate?

    // MARK: - Life Cycle

    init(frame: NSRect = .zero, delegate: CameraPreviewDelegate, quality: AVCaptureSession.Preset = .photo, isMirrored: Bool = true) {
        super.init(frame: frame)
        self.commonInit(delegate: delegate, quality: quality)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    private func commonInit(delegate: CameraPreviewDelegate? = nil, quality: AVCaptureSession.Preset = .photo, isMirrored: Bool = true) {
        self.delegate = delegate
        self.isMirrored = isMirrored
        self.setVideoQuality(quality)
        self.addSubview(cameraView)
    }

    override func updateConstraints() {
        super.updateConstraints()
        NSLayoutConstraint.activate([
            self.cameraView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.cameraView.topAnchor.constraint(equalTo: self.topAnchor),
            self.cameraView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.cameraView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

    override func layout() {
        super.layout()
        self.previewLayer.frame = self.cameraView.frame
    }

    // MARK: - Public Functions

    /// Configures the current AVCaptureSession Preset
    func setVideoQuality(_ quality: AVCaptureSession.Preset) {
        self.captureSession.sessionPreset = quality
    }

    /// Mirrors the preview
    func flipPreview(isMirrored: Bool) {
        self.previewLayer.connection?.automaticallyAdjustsVideoMirroring = false
        self.previewLayer.connection?.isVideoMirrored = isMirrored
    }

    /// Stops current AVCaptureSession
    func stopPreview() {
        self.captureSession.stopRunning()
    }

    /// Enables a snapshot from the current AVCaptureSession
    func takeSnapshot() {
        self.shouldCaptureSnapshot = true
    }

    /// Attempts to start a new AVCaptureSession if its NOT currently running OR it was chosen to override current session
    func startPreview(overrideCurrentSession: Bool = false) {
        if !self.captureSession.isRunning || overrideCurrentSession {
            if let captureDevice = self.captureDevice {
                do {
                    try self.captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))

                    self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                    self.previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill

                    self.flipPreview(isMirrored: isMirrored)

                    self.cameraView.layer?.addSublayer(previewLayer)

                    self.captureSession.startRunning()
                } catch {
                    self.delegate?.didEncounterError(error)
                }
            } else {
                self.delegate?.didEncounterError(CameraError.captureDeviceNotFound)
            }
        }
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension CameraPreview: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if self.shouldCaptureSnapshot {
            guard let snapshot = NSImage(sampleBuffer: sampleBuffer) else { return }
            self.delegate?.didTakeSnapshot(snapshot)
            self.shouldCaptureSnapshot = false
        }
     }
}
