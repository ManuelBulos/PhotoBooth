//
//  Line.swift
//  photobooth
//
//  Created by Manuel on 2/6/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

/// Drawing Line
struct Line {

    // MARK: - Properties

    var points: [CGPoint]
    let color: NSColor
    let width: CGFloat

    // MARK: - Functions

    /// Draws line in the current NSGraphicsContext
    func drawInCurrentContext() {
        guard let context = NSGraphicsContext.current?.cgContext else { return }

        context.setStrokeColor(color.cgColor)
        context.setLineWidth(width)
        context.setLineCap(.round)

        self.points.enumerated().forEach { (index: Int, point: CGPoint) in
            // if index == 0 it means it's a new point. so we move the context to the new starting position
            index == 0 ? context.move(to: point) : context.addLine(to: point)
        }

        context.strokePath()
    }
}

// MARK: - Array Extension

extension Array where Element == Line {

    /// Appends new NSPoint
    mutating func addPointToLastLine(_ point: NSPoint) {
        if var lastLine = self.popLast() {
            lastLine.points.append(point)
            self.append(lastLine)
        }
    }

    /// Draws lines in the current NSGraphicsContext
    func drawInCurrentContext() {
        self.forEach { $0.drawInCurrentContext() }
    }
}
