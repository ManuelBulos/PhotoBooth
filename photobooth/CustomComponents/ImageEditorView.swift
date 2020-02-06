//
//  ImageEditorView.swift
//  photobooth
//
//  Created by Manuel on 2/5/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

class ImageEditorView: NSView {

    private lazy var imageView: NSImageView = {
        let imageView = NSImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.imageScaling = .scaleProportionallyUpOrDown
        return imageView
    }()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        addSubview(imageView)
    }

    override func layout() {
        super.layout()
        imageView.frame = frame
    }

    func setImage(_ image: NSImage) {
        self.imageView.image = image
        removeDrawings()
    }

    /// Clears canvas
    func removeDrawings() {}

    /// Undos last continuous pencil strike
    func undoLastDrawing() {}
}
