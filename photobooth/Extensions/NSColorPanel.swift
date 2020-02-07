//
//  NSColorPanel.swift
//  photobooth
//
//  Created by Manuel on 2/7/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

extension NSColorPanel {
    func addTarget(_ target: Any, action: Selector) {
        self.setTarget(target)
        self.setAction(action)
    }
}
