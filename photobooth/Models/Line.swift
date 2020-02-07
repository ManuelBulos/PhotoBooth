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
        context.setLineCap(.butt)

        for (index, point) in points.enumerated() {
            if index == 0 {
                context.move(to: point)
            } else {
                context.addLine(to: point)
            }
        }

        context.strokePath()
    }
}

// MARK: - Array Extension

extension Array where Element == Line {
    mutating func addPointToLastLine(_ point: NSPoint) {
        if var lastLine = self.popLast() {
            lastLine.points.append(point)
            self.append(lastLine)
        }
    }
}
