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
        // open finder
    }

    func takeCameraSnapshotButtonClicked() {
        self.takeSnapshot()
    }

    func openImageButtonClicked() {
        // open finder and select image
    }

    func undoButtonClicked() {
        self.undoLastDrawing()
    }

    func clearButtonClicked() {
        self.clearCanvas()
    }

    func colorPickerButtonClicked() {
        // display color picker palette
    }
}

