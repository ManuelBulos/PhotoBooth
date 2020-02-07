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
    /// One line is a collection of points
    private var lines: [[CGPoint]] = [[CGPoint]]()

    // MARK: - Public Properties

    var lineColor: NSColor = .black

    var lineWidth: CGFloat = 10

    // MARK: - Life Cycle

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        guard let context = NSGraphicsContext.current?.cgContext else { return }
        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(lineWidth)
        context.setLineCap(.butt)

        self.lines.forEach { (line) in
            for (index, point) in line.enumerated() {
                if index == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
        }

        context.strokePath()
    }

    override func mouseDown(with event: NSEvent) {
        self.lines.append([CGPoint]())
        self.needsDisplay = true
    }

    override func mouseDragged(with event: NSEvent) {
        if var lastLine = self.lines.popLast() {
            let point = convert(event.locationInWindow, from: nil)
            lastLine.append(point)
            self.lines.append(lastLine)
            self.needsDisplay = true
        }
    }

    // MARK: - Public Functions

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
