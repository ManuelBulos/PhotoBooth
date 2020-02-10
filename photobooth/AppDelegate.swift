//
//  AppDelegate.swift
//  photobooth
//
//  Created by Manuel on 2/5/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {}
    func applicationWillTerminate(_ aNotification: Notification) {}

    func application(_ sender: NSApplication, openFiles filenames: [String]) {
        guard let fileName = filenames.first, let url = URL(string: fileName) else { return }
        if let photoBoothFile: PhotoBoothFile = MediaManager.shared.getPhotoBoothFileFrom(url) {
            NotificationCenter.default.post(name: .onClickedPhotoBoothFile, object: photoBoothFile)
        }
    }
}
