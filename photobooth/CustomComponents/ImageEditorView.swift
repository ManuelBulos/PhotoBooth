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

    // MARK: - Properties

    /// SVG XML data
    var svgString: String {
        return self.canvas.svgString
    }

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

    /// Sets the PhotoBoothFile
    func setPhotoBoothFile(_ photoBoothFile: PhotoBoothFile) {
        self.clearCanvas()
        self.imageView.image = photoBoothFile.image

        if let pencilData = photoBoothFile.pencilData {
            self.canvas.setPencilData(pencilData)
        }
    }

    /// Returns an PhotoBoothFile
    func getPhotoBoothFile() -> PhotoBoothFile? {
        guard let image = self.imageView.image else { return nil }
        let photoBoothFile = PhotoBoothFile(image: image, pencilData: canvas.getPencilData())
        photoBoothFile.imageWithPencilData = imageWithDrawings()
        return photoBoothFile
    }

    /// Returns an NSImage containing all the drawings
    func imageWithDrawings() -> NSImage {
        let mySize = bounds.size
        let imgSize = NSMakeSize(mySize.width, mySize.height)

        let bir = bitmapImageRepForCachingDisplay(in: bounds)
        bir?.size = imgSize

        if let bir = bir {
            cacheDisplay(in: bounds, to: bir)
        }

        let image = NSImage(size: imgSize)

        if let bir = bir {
            image.addRepresentation(bir)
        }

        return image
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
