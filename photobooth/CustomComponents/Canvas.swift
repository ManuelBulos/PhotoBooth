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

    /// All drawing is stored in a collection of lines.
    private var lines: [Line] = [Line]()

    // MARK: - Public Properties

    /// Width of the stroke, ddefaults to 10
    var lineWidth: CGFloat = 10

    /// Color of the stroke, defaults to black
    var lineColor: NSColor = .black

    // MARK: - Life Cycle

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        self.lines.forEach { (line) in
            line.drawInCurrentContext()
        }
    }

    override func mouseDown(with event: NSEvent) {
        let newLine: Line = Line(points: [CGPoint](), color: self.lineColor, width: self.lineWidth)
        self.lines.append(newLine)
        self.needsDisplay = true
    }

    override func mouseDragged(with event: NSEvent) {
        if var lastLine = self.lines.popLast() {
            let point = convert(event.locationInWindow, from: nil)
            lastLine.points.append(point)
            self.lines.append(lastLine)
            self.needsDisplay = true
        }
    }

    // MARK: - Functions

    /// Removes all drawings
    func clear() {
        self.lines.removeAll()
        self.needsDisplay = true
    }

    /// Removes last continuous line
    func undo() {
        _ = self.lines.popLast()
        self.needsDisplay = true
    }
}
