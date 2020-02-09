//
//  PDFDocument.swift
//  photobooth
//
//  Created by Manuel on 2/8/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Foundation
import Quartz

extension Data {
    /// Tries to save pdf into a given directory using a given name and extension
    func write(to directory: String, name: String) throws {
        let filePath: NSString = "file://\(directory)" as NSString
        guard let pathURL: URL = URL(string: filePath.appendingPathComponent(name)) else { return }
        try self.write(to: pathURL)
    }
}
