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
struct Line: Equatable {

    // MARK: - Properties

    var points: [CGPoint]
    let color: NSColor
    let width: CGFloat

    // MARK: - Life Cycle

    init(points: [CGPoint], color: NSColor, width: CGFloat) {
        self.points = points
        self.color = color
        self.width = width
    }

    init?(polyline: AEXMLElement, canvasHeight: Float) {
        guard let points = polyline.attributes["points"] else { return nil }

        let stringArray = points.split(separator: " ").compactMap { String($0) }

        let pointsArray = stringArray.compactMap { (string) -> CGPoint in
            let point = string.split(separator: ",")
            let xCoordinate: Float = Float(point.first ?? "") ?? .zero
            let yCoordinate: Float = Float(point.last ?? "") ?? .zero

            // We need to compensate for canvas heght and svg mirroring
            return CGPoint(x: CGFloat(xCoordinate), y: CGFloat(canvasHeight - yCoordinate))
        }

        let style = polyline.attributes["style"]

        var color: NSColor = .black

        var lineWidth: Float = 10

        if let hexColor: String = style?.slice(from: "#", to: ";") {
            color = NSColor(hexColor)
        }

        if let stringWidth: String = style?.slice(from: "stroke-width:", to: ";") {
            lineWidth = Float(stringWidth) ?? lineWidth
        }

        self.init(points: pointsArray, color: color, width: CGFloat(lineWidth))
    }

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
