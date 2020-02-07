//
//  ImageEditorView.swift
//  photobooth
//
//  Created by Manuel on 2/5/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

/// NSView that holds a Canvas above an NSImageView
class ImageEditorView: NSView {

    // MARK: - UI Elements

    private lazy var imageView: NSImageView = {
        let imageView = NSImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.imageScaling = .scaleProportionallyUpOrDown
        return imageView
    }()

    private lazy var canvas: Canvas = {
        let canvas = Canvas(undosLimit: 6)
        canvas.translatesAutoresizingMaskIntoConstraints = false
        return canvas
    }()

    // MARK: - Life Cycle

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    private func commonInit() {
        self.addSubview(imageView)
        self.addSubview(canvas)
        NSColorPanel.shared.addTarget(self, action: #selector(didSelectColor(_:)))
    }

    override func layout() {
        super.layout()
        imageView.frame = frame
        canvas.frame = frame
    }

    // MARK: - Private Functions

    @objc private func didSelectColor(_ sender: NSColorPanel) {
        self.setLineColor(sender.color)
    }

    // MARK: - Public Functions

    /// Sets the new image
    func setImage(_ image: NSImage) {
        self.imageView.image = image
    }

    /// Shows an NSColorPanel window
    func openColorPicker() {
        NSColorPanel.shared.makeKeyAndOrderFront(self)
    }

    /// Dismisses an NSColorPanel window
    func closeColorPicker() {
        NSColorPanel.shared.orderOut(self)
    }

    /// Sets the width of the line stroke in the canvas
    func setLineWidth(_ width: CGFloat) {
        self.canvas.lineWidth = width
    }

    /// Sets the color of the line stroke in the canvas
    func setLineColor(_ color: NSColor) {
        self.canvas.lineColor = color
    }

    /// Removes all drawings from the canvas
    func clearCanvas() {
        self.canvas.clear()
    }

    /// Removes last continuous line from the canvas
    func undo() {
        self.canvas.undo()
    }

    func initWorkspace(showColorPicker: Bool) {
        self.clearCanvas()
        self.setLineColor(NSColorPanel.shared.color)
        showColorPicker ? self.openColorPicker() : self.closeColorPicker()
    }
}

