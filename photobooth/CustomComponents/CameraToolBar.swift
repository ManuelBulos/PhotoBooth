//
//  CameraToolBar.swift
//  photobooth
//
//  Created by Manuel on 2/5/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

/// CameraToolBar class delegate
protocol CameraToolBarDelegate: AnyObject {
    func newFileButtonClicked()
    func saveFileButtonClicked()
    func takeCameraSnapshotButtonClicked()
    func openImageButtonClicked()
    func undoButtonClicked()
    func colorPickerButtonClicked()
}

/// NSView with user interaction buttons
class CameraToolBar: NSView {

    // MARK: - UI Elements

    private lazy var stackView: NSStackView = {
        let stackView = NSStackView(views: [newFileButton, saveFileButton, takeCameraSnapshotButton, openImageButton, undoButton, colorPickerButton])
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var newFileButton: NSButton = {
        let newFileButton = NSButton(title: "New File",
                                     target: self,
                                     action: #selector(newFileButtonClicked))
        return newFileButton
    }()

    private lazy var saveFileButton: NSButton = {
        let saveFileButton = NSButton(title: "Save File",
                                      target: self,
                                      action: #selector(saveFileButtonClicked))
        return saveFileButton
    }()

    private lazy var takeCameraSnapshotButton: NSButton = {
        let takeCameraSnapshotButton = NSButton(title: "Take Snapshot",
                                                target: self,
                                                action: #selector(takeCameraSnapshotButtonClicked))
        return takeCameraSnapshotButton
    }()

    private lazy var openImageButton: NSButton = {
        let openImageButton = NSButton(title: "Open",
                                       target: self,
                                       action: #selector(openImageButtonClicked))
        return openImageButton
    }()

    private lazy var undoButton: NSButton = {
        let undoButton = NSButton(title: "Undo",
                                  target: self,
                                  action: #selector(undoButtonClicked))
        return undoButton
    }()

    private lazy var colorPickerButton: NSButton = {
        let colorPickerButton = NSButton(title: "Color picker",
                                         target: self,
                                         action: #selector(colorPickerButtonClicked))
        return colorPickerButton
    }()

    // MARK: - Public Properties

    weak var delegate: CameraToolBarDelegate?

    // MARK: - Life Cycle

    init(frame: NSRect = .zero, hideEditingButtons: Bool = true, delegate: CameraToolBarDelegate) {
        super.init(frame: frame)
        self.delegate = delegate
        commonInit(hideEditingButtons: hideEditingButtons)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit(hideEditingButtons: Bool = true) {
        addSubviews()
        setEditingButtonsStatus(hidden: hideEditingButtons)
    }

    override func updateConstraints() {
        super.updateConstraints()
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }

    // MARK: - Private Functions

    private func addSubviews() {
        addSubview(stackView)
    }

    // MARK: - Public Functions

    func setEditingButtonsStatus(hidden: Bool) {
        // Editing buttons should hide when taking a picture
        undoButton.isHidden = hidden
        newFileButton.isHidden = hidden
        saveFileButton.isHidden = hidden
        colorPickerButton.isHidden = hidden

        openImageButton.isHidden = !hidden
        takeCameraSnapshotButton.isHidden = !hidden
    }

    // MARK: - User Interactions (Button clicks)

    @objc private func newFileButtonClicked() {
        delegate?.newFileButtonClicked()
    }

    @objc private func saveFileButtonClicked() {
        delegate?.saveFileButtonClicked()
    }

    @objc private func takeCameraSnapshotButtonClicked() {
        delegate?.takeCameraSnapshotButtonClicked()
    }

    @objc private func openImageButtonClicked() {
        delegate?.openImageButtonClicked()
    }

    @objc private func undoButtonClicked() {
        delegate?.undoButtonClicked()
    }

    @objc private func colorPickerButtonClicked() {
        delegate?.colorPickerButtonClicked()
    }
}
