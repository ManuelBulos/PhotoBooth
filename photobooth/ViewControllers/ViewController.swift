//
//  ViewController.swift
//  photobooth
//
//  Created by Manuel on 2/5/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    // MARK: - UI Elements

    private lazy var stackView: NSStackView = {
        let stackView = NSStackView(views: [cameraPreview, imageEditorView, cameraToolBar])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
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

    // MARK: - Private Properties

    private let mainViewAspectRatio: CGFloat = 1.35

    // MARK: - Life Cycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        showCameraPreview()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        NSLayoutConstraint.activate([
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        ])

        // Locks the aspect ratio of the controller's view
        view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: self.mainViewAspectRatio).isActive = true
    }

    // MARK: - Private Functions

    private func addSubviews() {
        view.addSubview(stackView)
    }

    private func showImageEditorView(image: NSImage) {
        cameraPreview.isHidden = true
        imageEditorView.isHidden = false
        imageEditorView.setImage(image)
        cameraToolBar.setEditingButtonsStatus(hidden: false)
    }

    private func showCameraPreview() {
        cameraPreview.startPreview()
        cameraPreview.isHidden = false
        imageEditorView.isHidden = true
        cameraToolBar.setEditingButtonsStatus(hidden: true)
    }
}

// MARK: - CameraPreviewDelegate

extension ViewController: CameraPreviewDelegate {
    func didTakeSnapshot(_ snapshot: NSImage) {
        showImageEditorView(image: snapshot)
    }
}

// MARK: - CameraToolBarDelegate

extension ViewController: CameraToolBarDelegate {
    func newFileButtonClicked() {
        let alert = NSAlert(message: "All changes will be lost, are you sure?",
                            firstButtonTitle: "Yes, create new file")

        if alert.runModal() == .alertFirstButtonReturn {
            showCameraPreview()
        }
    }

    func saveFileButtonClicked() {
        // open finder
    }

    func takeCameraSnapshotButtonClicked() {
        cameraPreview.takeSnapshot()
    }

    func openImageButtonClicked() {
        // open finder and select image
    }

    func undoButtonClicked() {
        imageEditorView.undoLastDrawing()
    }

    func colorPickerButtonClicked() {
        // display color picker palette
    }
}

