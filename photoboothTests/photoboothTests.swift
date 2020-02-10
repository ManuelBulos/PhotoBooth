//
//  photoboothTests.swift
//  photoboothTests
//
//  Created by Manuel on 2/5/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import XCTest
import Quartz
@testable import photobooth

class photoboothTests: XCTestCase {

    /// String File Extensions
    func testAllOpenFileExtensions() {
        OpenFileExtension.allCases.forEach { (ext) in
            let fileName: String = "selfie"
            let fileNameWithExtension = fileName.addExtension(ext)
            let expectedString = "\(fileName).\(ext.rawValue)"
            XCTAssert(fileNameWithExtension == expectedString)
        }
    }

    /// String File Extensions
    func testAllSaveFileExtensions() {
        SaveFileExtension.allCases.forEach { (ext) in
            let fileName: String = "selfie"
            let fileNameWithExtension = fileName.addExtension(ext)
            let expectedString = "\(fileName).\(ext.rawValue)"
            XCTAssert(fileNameWithExtension == expectedString)
        }
    }

    /// Hex string to NSColor and viceversa
    func testHexToColor() {
        let hexValue: String = "#99FF33"
        let color: NSColor = NSColor(hexValue)
        XCTAssert(color.hexValue == hexValue)
    }

    /// PencilData to SVG and viceversa
    func testSVGParser() {
        let width: CGFloat = 578.0
        let height: CGFloat = 375.0
        let colorHex: String = "#FF40FF"
        let strokeWidth: CGFloat = 10.0

        let pencilDataFromCode: PencilData = PencilData()

        let points: [CGPoint] = [CGPoint(x: 190, y: height - 110),
                                 CGPoint(x: 195, y: height - 115),
                                 CGPoint(x: 200, y: height - 120)]

        let line: Line = Line(points: points, color: NSColor(colorHex), width: strokeWidth)

        pencilDataFromCode.addLine(line)

        pencilDataFromCode.setCanvasSize(CGSize(width: width, height: height))

        let expectedSVGString: String = pencilDataFromCode.getSVGString(size: CGSize(width: width, height: height))

        do {
            let xmlDocument: AEXMLDocument = try AEXMLDocument(xml: expectedSVGString)
            let pencilDataFromSVG: PencilData = PencilData(xml: xmlDocument)
            XCTAssert(pencilDataFromSVG == pencilDataFromCode)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    /// Saving and reading .photobooth, .png and .svg files
    func testSavingAndReadingFiles() {
        let photoBoothFile = PhotoBoothFile(image: NSImage())

        guard let path = MediaManager.shared.saveFile(photoBoothFile) else {
            XCTFail("Failed to save file")
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard let retrievedPhotoBoothFile = MediaManager.shared.getPhotoBoothFileFrom(path) else {
                XCTFail("Failed to retrieve file from \(path)")
                return
            }

            XCTAssert(photoBoothFile == retrievedPhotoBoothFile)
        }
    }
}
