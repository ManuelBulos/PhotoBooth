//
//  NSImage.swift
//  photobooth
//
//  Created by Manuel on 2/5/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa
import AVFoundation

extension NSImage {

    /// Returns an bitmapImage using PNG format
    var pngData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        return bitmapImage.representation(using: .png, properties: [:])
    }

    /// Inits an NSImage from a CMSampleBuffer
    convenience init?(sampleBuffer: CMSampleBuffer, bitsPerComponent: Int = 8) {

        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }

        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)

        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)

        guard let context = CGContext(data: CVPixelBufferGetBaseAddress(pixelBuffer),
                                      width: CVPixelBufferGetWidth(pixelBuffer),
                                      height: CVPixelBufferGetHeight(pixelBuffer),
                                      bitsPerComponent: bitsPerComponent,
                                      bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer),
                                      space: CGColorSpaceCreateDeviceRGB(),
                                      bitmapInfo: bitmapInfo.rawValue) else { return nil }

        guard let cgImage = context.makeImage() else { return nil }

        CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)

        self.init(cgImage: cgImage, size: .zero)
    }

    /// Tries to save image into a given directory using a given name and extension
    func write(to directory: String, name: String) throws {
        let filePath: NSString = "file://\(directory)" as NSString
        guard let pathURL: URL = URL(string: filePath.appendingPathComponent(name)) else { return }
        try self.pngData?.write(to: pathURL)
    }
}
