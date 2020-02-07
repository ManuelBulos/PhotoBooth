//
//  NSEvent.swift
//  photobooth
//
//  Created by Manuel on 2/7/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

extension NSEvent {
    func getPoint(inView: NSView) -> NSPoint {
        return inView.convert(self.locationInWindow, from: nil)
    }
}
