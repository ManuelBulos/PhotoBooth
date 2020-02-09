//
//  Line.swift
//  photobooth
//
//  Created by Manuel on 2/6/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa
import Quartz

/// Drawing Line
struct Line {

    // MARK: - Properties

    var points: [CGPoint]
    let color: NSColor
    let width: CGFloat

    // MARK: - Life Cycle

//    init(polyline: String) {
//
//    }

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
