//
//  SaveFileExtension.swift
//  photobooth
//
//  Created by Manuel on 2/10/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Foundation

/// Supported file extensions for saving files
enum SaveFileExtension: String, CaseIterable, FileExtensionProtocol {
    case png
    case photobooth

    var string: String {
        return self.rawValue
    }
}
