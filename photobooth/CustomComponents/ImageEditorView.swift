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
        let canvas = Canvas()
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
        self.addSubview(canvas, positioned: .above, relativeTo: imageView)
    }

    override func layout() {
        super.layout()
        imageView.frame = frame
        canvas.frame = frame
    }

    // MARK: - Functions

    /// Sets the image and clears the canvas
    func setImage(_ image: NSImage) {
        self.imageView.image = image
        self.canvas.clear()
    }

    /// Removes all drawings from the canvas
    func clearCanvas() {
        self.canvas.clear()
    }

    /// Removes last continuous line from the canvas
    func undo() {
        self.canvas.undo()
    }
}
