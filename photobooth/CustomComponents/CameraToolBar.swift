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
    func clearButtonClicked()
    func colorPickerButtonClicked()
}

/// NSView with buttons for controlling the camera and a canvas
class CameraToolBar: NSView {

    // MARK: - UI Elements

    private lazy var stackView: NSStackView = {
        let stackView = NSStackView(views: [takeCameraSnapshotButton,
                                            openImageButton,
                                            newFileButton,
                                            saveFileButton,
                                            undoButton,
                                            clearButton,
                                            colorPickerButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 12
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

    private lazy var clearButton: NSButton = {
        let clearButton = NSButton(title: "Clear",
                                   target: self,
                                   action: #selector(clearButtonClicked))
        return clearButton
    }()

    private lazy var colorPickerButton: NSButton = {
        let colorPickerButton = NSButton(title: "Color picker",
                                         target: self,
                                         action: #selector(colorPickerButtonClicked))
        return colorPickerButton
    }()

    // MARK: - Private Properties

    private let stackViewPadding: CGFloat = 12

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
        addSubview(stackView)
        self.hideEditingButtons(hideEditingButtons)
    }

    override func updateConstraints() {
        super.updateConstraints()
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: stackViewPadding),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: stackViewPadding),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -stackViewPadding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -stackViewPadding),
        ])
    }

    // MARK: - Public Functions

    func hideEditingButtons(_ hideEditingButtons: Bool) {
        undoButton.isHidden = hideEditingButtons
        clearButton.isHidden = hideEditingButtons
        newFileButton.isHidden = hideEditingButtons
        saveFileButton.isHidden = hideEditingButtons
        colorPickerButton.isHidden = hideEditingButtons

        openImageButton.isHidden = !hideEditingButtons
        takeCameraSnapshotButton.isHidden = !hideEditingButtons
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

    @objc private func clearButtonClicked() {
        delegate?.clearButtonClicked()
    }

    @objc private func colorPickerButtonClicked() {
        delegate?.colorPickerButtonClicked()
    }
}
