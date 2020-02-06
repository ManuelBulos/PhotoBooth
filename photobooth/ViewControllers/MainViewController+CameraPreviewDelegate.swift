//
//  MainViewController+CameraPreviewDelegate.swift
//  photobooth
//
//  Created by Manuel on 2/5/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

extension MainViewController: CameraPreviewDelegate {
    func didEncounterError(_ error: Error) {
        NSAlert(error: error).runModal()
    }

    func didTakeSnapshot(_ snapshot: NSImage) {
        self.showImageEditorView(image: snapshot)
    }
}
