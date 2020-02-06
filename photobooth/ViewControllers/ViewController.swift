//
//  ViewController.swift
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
        view.addSubview(stackView)
        showCameraPreview()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        NSLayoutConstraint.activate([
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor)
        ])

        // Locks the aspect ratio of the controller's view
        view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: self.mainViewAspectRatio).isActive = true
    }

    // MARK: - Private Functions

    private func showImageEditorView(image: NSImage) {
        imageEditorView.setImage(image)

        cameraPreview.isHidden = true
        imageEditorView.isHidden = false
        cameraToolBar.hideEditingButtons(false)
    }

    private func showCameraPreview() {
        cameraPreview.startPreview()

        cameraPreview.isHidden = false
        imageEditorView.isHidden = true
        cameraToolBar.hideEditingButtons(true)
        toggleViews()
    }

    fileprivate func toggleViews() {

    }
}

// MARK: - CameraPreviewDelegate

extension MainViewController: CameraPreviewDelegate {
    func didEncounterError(_ error: Error) {
        NSAlert(error: error).runModal()
    }

    func didTakeSnapshot(_ snapshot: NSImage) {
        showImageEditorView(image: snapshot)
    }
}

// MARK: - CameraToolBarDelegate

extension MainViewController: CameraToolBarDelegate {
    func newFileButtonClicked() {
        let alert = NSAlert(message: "All changes will be lost, are you sure?",
                            firstButtonTitle: "Yes, create new file")

        let shouldCreateNewFile: Bool = alert.runModal() == .alertFirstButtonReturn

        if shouldCreateNewFile {
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

