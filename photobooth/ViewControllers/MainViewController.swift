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
        stackView.distribution = .equalCentering
        stackView.orientation = .vertical
        return stackView
    }()

    internal lazy var cameraPreview: CameraPreview = {
        let cameraPreview = CameraPreview(delegate: self)
        cameraPreview.translatesAutoresizingMaskIntoConstraints = false
        return cameraPreview
    }()

    internal lazy var cameraToolBar: CameraToolBar = {
        let cameraToolBar = CameraToolBar(delegate: self)
        cameraToolBar.translatesAutoresizingMaskIntoConstraints = false
        return cameraToolBar
    }()

    internal lazy var imageEditorView: ImageEditorView = {
        let imageEditorView = ImageEditorView()
        imageEditorView.translatesAutoresizingMaskIntoConstraints = false
        return imageEditorView
    }()

    internal lazy var newFileWarningAlert: NSAlert = {
        return NSAlert(message: "All changes will be lost, are you sure?",
                       firstButtonTitle: "Continue")
    }()

    // MARK: - Private Properties

    private let mainViewAspectRatio: CGFloat = 1.35

    // MARK: - Public Properties


    // MARK: - Life Cycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)

        self.showCameraPreview()

        NotificationCenter.default.addObserver(self, selector: #selector(onClickedPhotoBoothFile(_:)), name: .onClickedPhotoBoothFile, object: nil)
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        NSLayoutConstraint.activate([
            // StackView
            self.stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.stackView.topAnchor.constraint(equalTo: view.topAnchor),

            // Locks the aspect ratio of the controller's view
            view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: self.mainViewAspectRatio)
        ])
    }

    // MARK: - Functions

    @objc private func onClickedPhotoBoothFile(_ sender: Notification) {
        guard let photoBoothFile = sender.object as? PhotoBoothFile else { return }
        self.showImageEditorView(photoBoothFile: photoBoothFile)
    }

    /// Shows the Camera Preview and hides the ImageEditorView
    internal func showCameraPreview() {
        self.cameraPreview.startPreview()
        self.imageEditorView.closeColorPicker()
        self.toggleHiddenViews(isEditing: false)
    }

    /// Shows the ImageEditorView and hides the Camera Preview
    internal func showImageEditorView(photoBoothFile: PhotoBoothFile) {
        self.imageEditorView.setPhotoBoothFile(photoBoothFile)
        self.imageEditorView.openColorPicker()
        self.toggleHiddenViews(isEditing: true)
    }

    /// Toggles isHidden properties for cameraPreview, imageEditorView and cameraToolBar buttons
    private func toggleHiddenViews(isEditing: Bool) {
        self.cameraPreview.isHidden = isEditing
        self.imageEditorView.isHidden = !isEditing
        self.cameraToolBar.hideEditingButtons(!isEditing)
    }
}
