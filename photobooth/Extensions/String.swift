//
//  String.swift
//  photobooth
//
//  Created by Manuel on 2/9/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Foundation

extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }

    func addExtension(_ fileExtension: FileExtensionProtocol) -> String {
        return "\(self).\(fileExtension.string)"
    }
}
