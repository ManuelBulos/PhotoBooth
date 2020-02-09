//
//  ImageEditorView.swift
//  photobooth
//
//  Created by Manuel on 2/5/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa
import Quartz

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
    }

    override func layout() {
        super.layout()
        imageView.frame = frame
        canvas.frame = frame
    }

    // MARK: - Public Functions

    /// Sets the new image and clears canvas
    func setImage(_ image: NSImage) {
        self.imageView.image = image
        self.clearCanvas()
    }

    func getFinalImageResult() -> NSImage? {
        return self.imageView.image
    }

    func getPhotoBoothDocument() -> Data? {
        return self.canvas.getPDFData()
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

    /// Removes all drawings from the canvas
    func clearCanvas() {
        self.canvas.clear()
    }

    /// Removes last continuous line from the canvas
    func undo() {
        self.canvas.undo()
    }
}

extension NSImage {
    var context: CGContext? {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let size = self.size
        let contextRef = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 1)
        var graphicsContext: NSGraphicsContext? = nil
        if let contextRef = contextRef {
            graphicsContext = NSGraphicsContext(cgContext: contextRef, flipped: false)
        }

        let currentContext = NSGraphicsContext.current
        NSGraphicsContext.current = graphicsContext
        self.draw(in: NSRect(x: 0, y: 0, width: size.width, height: size.height))
        NSGraphicsContext.current = currentContext

        return contextRef
    }
}


