//
//  MainViewController+CameraToolBarDelegate.swift
//  photobooth
//
//  Created by Manuel on 2/5/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

extension MainViewController: CameraToolBarDelegate {
    func newFileButtonClicked() {
        self.createNewFile()
    }

    func saveFileButtonClicked() {
        self.saveFile()
    }

    func takeCameraSnapshotButtonClicked() {
        self.takeSnapshot()
    }

    func openFileButtonClicked() {
        self.openFile()
    }

    func undoButtonClicked() {
        self.undoLastDrawing()
    }

    func clearCanvasButtonClicked() {
        self.clearCanvas()
    }

    func colorPickerButtonClicked() {
        self.openColorPicker()
    }
}
