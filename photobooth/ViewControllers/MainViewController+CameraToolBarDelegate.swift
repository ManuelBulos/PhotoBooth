//
//  MainViewController+CameraToolBarDelegate.swift
//  photobooth
//
//  Created by Manuel on 2/5/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

extension MainViewController: CameraToolBarDelegate {
    /// Shows warning about losing all changes, if accepted it will take you back to the camera preview
    func newFileButtonClicked() {
        let userAcceptedWarning: Bool = self.newFileWarningAlert.runModal() == .alertFirstButtonReturn
        if userAcceptedWarning { self.showCameraPreview() }
    }

    /// Tries to save current file
    func saveFileButtonClicked() {
        guard let photoBoothFile: PhotoBoothFile = imageEditorView.getPhotoBoothFile() else { return }
        MediaManager.shared.saveFile(photoBoothFile)
    }

    /// Captures a still image from the current AVCapture Session
    func takeCameraSnapshotButtonClicked() {
        self.cameraPreview.takeSnapshot()
    }

    /// Opens photobooth file selected by user
    func openFileButtonClicked() {
        guard let photoBoothFile = MediaManager.shared.openFile() else { return }
        self.showImageEditorView(photoBoothFile: photoBoothFile)
    }

    /// Undos last continuous pencil strike
    func undoButtonClicked() {
        self.imageEditorView.undo()
    }

    /// Shows warning about losing all changes, if accepted it will clear all drawings from canvas
    func clearCanvasButtonClicked() {
        let userAcceptedWarning: Bool = self.newFileWarningAlert.runModal() == .alertFirstButtonReturn
        if userAcceptedWarning { self.imageEditorView.clearCanvas() }
    }

    /// Presents new window with a color picker
    func colorPickerButtonClicked() {
        self.imageEditorView.openColorPicker()
    }
}
