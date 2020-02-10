//
//  PhotoBoothFile.swift
//  photobooth
//
//  Created by Manuel on 2/9/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

/// Object that stores all file types used in the app
class PhotoBoothFile {

    /// Unedited NSImage
    var image: NSImage

    /// Drawings
    var pencilData: PencilData?

    /// NSImage with drawing data
    var imageWithPencilData: NSImage?

    /// returns true if user draw at least one line in the canvas
    var hasPencilData: Bool {
        guard let containsLines = pencilData?.lines.isEmpty else { return false }
        return !containsLines
    }

    init(image: NSImage, pencilData: PencilData? = nil) {
        self.image = image
        self.pencilData = pencilData
    }

    /// Stores the image with drawing data
    func setImageWithPencilData(_ image: NSImage) {
        self.imageWithPencilData = image
    }
}
