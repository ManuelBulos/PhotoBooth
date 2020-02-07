//
//  Canvas.swift
//  photobooth
//
//  Created by Manuel on 2/6/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

/// NSView that supports drawing with the mouse
class Canvas: NSView {

    // MARK: - Private Properties

    /// All drawing is stored in a collection of lines
    private var lines: [Line] = [Line]()

    /// Undos counter, starts at 0
    private var undosCounter: Int = 0

    /// Defaults to infinite
    private var undosLimit: Int?

    // MARK: - Public Properties

    /// Width of the stroke, ddefaults to 10
    var lineWidth: CGFloat = 10

    /// NSColorPanel shared selected color
    var lineColor: NSColor {
        return NSColorPanel.shared.color
    }

    // MARK: - Life Cycle

    init(undosLimit: Int? = nil) {
        super.init(frame: .zero)
        commonInit(undosLimit: undosLimit)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit(undosLimit: Int? = nil) {
        self.undosLimit = undosLimit
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.lines.drawInCurrentContext()
    }

    override func mouseDown(with event: NSEvent) {
        if undosCounter > 0 { undosCounter -= 1 }

        self.lines.append(Line(points: [CGPoint](),
                               color: self.lineColor,
                               width: self.lineWidth))
        self.needsDisplay = true
    }

    override func mouseDragged(with event: NSEvent) {
        self.lines.addPointToLastLine(event.getPoint(inView: self))
        self.needsDisplay = true
    }

    // MARK: - Functions

    /// Removes all drawings and restarts undos counter
    func clear() {
        self.undosCounter = Int()
        self.lines.removeAll()
        self.needsDisplay = true
    }

    /// Removes last continuous line
    func undo() {
        // avoids undoing if canvas is empty
        if lines.isEmpty { return }

        // avoids undoing if undos limit has been reached
        if let undosLimit = undosLimit,
            undosCounter >= undosLimit {
            return
        }

        _ = self.lines.popLast()
        self.needsDisplay = true
        undosCounter += 1
    }
}
