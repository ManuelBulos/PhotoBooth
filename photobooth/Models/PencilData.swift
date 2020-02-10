//
//  PencilData.swift
//  photobooth
//
//  Created by Manuel on 2/9/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

/// Data from the Drawing canvas
class PencilData {

    /// All drawing is stored in a collection of lines.
    /// Each Line object stores an array of CGPoints
    private(set) var lines: [Line] = [Line]()

    /// Stores the CGSize of the canvas
    private(set) var canvasSize: CGSize?

    /// Returns true if lines array is empty
    var isEmpty: Bool {
        return lines.isEmpty
    }

    init() {
        self.lines = [Line]()
    }

    init(xml: AEXMLDocument) {
        let svg = xml.root.attributes
        let width = Float(svg["width"] ?? "") ?? .zero
        let height = Float(svg["height"] ?? "") ?? .zero
        self.setCanvasSize(CGSize(width: CGFloat(width), height: CGFloat(height)))

        if let polylines = xml.root["polyline"].all {
            for polyline in polylines {
                guard let line = Line(polyline: polyline, canvasHeight: height) else { continue }
                self.lines.append(line)
            }
        }
    }

    /// Adds a new line to the array
    func addLine(_ line: Line) {
        self.lines.append(line)
    }

    /// Pops last line
    func popLastLine() {
        _ = self.lines.popLast()
    }

    /// Removes all lines
    func removeAllLines() {
        self.lines.removeAll()
    }

    /// Draws lines in the current NSGraphicsContext
    func drawInCurrentContext() {
        self.lines.forEach { $0.drawInCurrentContext() }
    }

    /// Appends new NSPoint
    func addPointToLastLine(_ point: NSPoint) {
        if var lastLine = self.lines.popLast() {
            lastLine.points.append(point)
            self.lines.append(lastLine)
        }
    }

    /// Stores the size of the working canvas
    func setCanvasSize(_ size: CGSize) {
        self.canvasSize = size
    }

    /// Returns svg xml string, if size is nil, it takes the working canvas size
    func getSVGString(size: CGSize? = nil) -> String {
        var polylines: [String] = [String]()

        let size = size ?? self.canvasSize ?? .zero

        for line in lines {
            // for each ("continuous") line we create a new polyline point
            let allPoints: String = line.points.map({ "\($0.x),\(size.height - $0.y)" }).joined(separator: " ")
            let strokeColor: String = line.color.hexValue
            let strokeWidth: String = "\(line.width)"
            let polyline: String = "<polyline points=\"\(allPoints)\" style=\"fill:none;stroke:\(strokeColor);stroke-width:\(strokeWidth);\"/>"
            polylines.append(polyline)
        }

        let svg: String =
        """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE svg>
        <svg xmlns="http://www.w3.org/2000/svg" width="\(size.width)" height="\(size.height)">
        \(polylines.joined())
        </svg>
        """

        return svg
    }
}

extension PencilData: Equatable {
    static func == (lhs: PencilData, rhs: PencilData) -> Bool {
        return lhs.lines == rhs.lines && lhs.canvasSize == rhs.canvasSize
    }
}
