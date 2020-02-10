//
//  OpenFileExtension.swift
//  photobooth
//
//  Created by Manuel on 2/10/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Foundation

/// Supported file extensions for opening files
enum OpenFileExtension: String, CaseIterable, FileExtensionProtocol {
    case png
    case photobooth
    case svg

    var string: String {
        return self.rawValue
    }
}
