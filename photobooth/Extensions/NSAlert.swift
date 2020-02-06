
//
//  NSAlert.swift
//  photobooth
//
//  Created by Manuel on 2/5/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

extension NSAlert {
    convenience init(message: String, firstButtonTitle: String = "Ok", secondButtonTitle: String = "Cancel") {
        self.init()
        self.messageText = message
        self.alertStyle = .warning
        self.addButton(withTitle: firstButtonTitle)
        self.addButton(withTitle: secondButtonTitle)
    }
}
