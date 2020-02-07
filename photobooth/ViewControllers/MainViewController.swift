//
//  MainViewController.swift
//  photobooth
//
//  Created by Manuel on 2/5/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    // MARK: - UI Elements

    private lazy var stackView: NSStackView = {
        let stackView = NSStackView(views: [cameraPreview, imageEditorView, cameraToolBar])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.orientation = .vertical
        return stackView
    }()

    private lazy var cameraPreview: CameraPreview = {
        let cameraPreview = CameraPreview(delegate: self)
        cameraPreview.translatesAutoresizingMaskIntoConstraints = false
        return cameraPreview
    }()

    private lazy var cameraToolBar: CameraToolBar = {
        let cameraToolBar = CameraToolBar(delegate: self)
        cameraToolBar.translatesAutoresizingMaskIntoConstraints = false
        return cameraToolBar
    }()

    private lazy var imageEditorView: ImageEditorView = {
        let imageEditorView = ImageEditorView()
        imageEditorView.translatesAutoresizingMaskIntoConstraints = false
        return imageEditorView
    }()

    private lazy var newFileWarningAlert: NSAlert = {
        return NSAlert(message: "All changes will be lost, are you sure?",
                       firstButtonTitle: "Continue")
    }()

    // MARK: - Private Properties

    private let mainViewAspectRatio: CGFloat = 1.35

    // MARK: - Life Cycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        showCameraPreview()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        NSLayoutConstraint.activate([
            // StackView
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            // Locks the aspect ratio of the controller's view
            view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: self.mainViewAspectRatio)
        ])
    }

    // MARK: - Functions

    /// Shows warning about losing all changes, if accepted it will take you back to the camera preview
    internal func createNewFile() {
        let userAcceptedWarning: Bool = newFileWarningAlert.runModal() == .alertFirstButtonReturn
        if userAcceptedWarning { self.showCameraPreview() }
    }

    /// Shows the ImageEditorView and hides the Camera Preview
    internal func showImageEditorView(image: NSImage) {
        imageEditorView.setImage(image)
        imageEditorView.openColorPicker()
        toggleState(isEditing: true)
    }

    /// Shows the Camera Preview and hides the ImageEditorView
    private func showCameraPreview() {
        cameraPreview.startPreview()
        imageEditorView.closeColorPicker()
        toggleState(isEditing: false)
    }

    /// Toggles isHidden properties for cameraPreview and imageEditorView.
    private func toggleState(isEditing: Bool) {
        cameraPreview.isHidden = isEditing
        imageEditorView.isHidden = !isEditing
        cameraToolBar.hideEditingButtons(!isEditing)
    }

    /// Captures a still image from the current AVCapture Session
    internal func takeSnapshot() {
        cameraPreview.takeSnapshot()
    }

    /// Undos last continuous pencil strike
    internal func undoLastDrawing() {
        imageEditorView.undo()
    }

    /// Shows warning about losing all changes, if accepted it will clear all drawings from canvas
    internal func clearCanvas() {
        let userAcceptedWarning: Bool = newFileWarningAlert.runModal() == .alertFirstButtonReturn
        if userAcceptedWarning { imageEditorView.clearCanvas() }
    }

    /// Presents new window with a color picker
    internal func openColorPicker() {
        imageEditorView.openColorPicker()
    }
}
