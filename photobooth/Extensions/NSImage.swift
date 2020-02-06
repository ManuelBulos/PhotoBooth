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
}
