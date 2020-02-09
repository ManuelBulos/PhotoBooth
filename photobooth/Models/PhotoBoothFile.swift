//
//  PhotoBoothFile.swift
//  photobooth
//
//  Created by Manuel on 2/9/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

class PhotoBoothFile: NSDocument {

    var image: NSImage

    var pencilData: PencilData?

    init(image: NSImage, pencilData: PencilData? = nil) {
        self.image = image
        self.pencilData = pencilData
        super.init()
    }
}
