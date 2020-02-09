//
//  MediaManager.swift
//  photobooth
//
//  Created by Manuel on 2/7/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa
import Quartz

class MediaManager {

    // MARK: - Types

    private enum FileExtension: String, CaseIterable {
        case png
        case jpeg
        case svg
        case photobooth

        var stringValue: String {
            return "\(self.rawValue)"
        }
    }

    // MARK: - UI Elements

    private lazy var savePanel: NSSavePanel = {
        let savePanel = NSSavePanel()
        savePanel.accessoryView = fileExtensionButton
        savePanel.allowedFileTypes = [FileExtension.png.stringValue]
        savePanel.allowsOtherFileTypes = false
        return savePanel
    }()

    private lazy var openPanel: NSOpenPanel = {
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = FileExtension.allCases.map({ $0.stringValue })
        openPanel.allowsMultipleSelection = false
        openPanel.allowsOtherFileTypes = false
        return openPanel
    }()

    private lazy var fileExtensionButton: NSPopUpButton = {
        let fileExtensionButton = NSPopUpButton()
        fileExtensionButton.addItems(withTitles: FileExtension.allCases.map { $0.stringValue } )
        fileExtensionButton.action = #selector(selectedExtensionChanged)
        fileExtensionButton.target = self
        return fileExtensionButton
    }()

    // MARK: - Public Properties

    static var shared: MediaManager = MediaManager()

    // MARK: - Functions

    @objc private func selectedExtensionChanged(_ sender: NSPopUpButton) {
        guard let selectedExtension = sender.selectedItem?.title else { return }
        savePanel.allowedFileTypes = [selectedExtension]
    }

    // FIXME: Find the right way to open bundle packages (collection of files inside a custom extension directory (.photobooth))
//    func openFile() -> PhotoBoothFile? {
//        if openPanel.runModal() == .OK {
//            guard let selectedFilePath: URL = openPanel.urls.first else { return nil }
//            if let image = NSImage(contentsOf: selectedFilePath) {
//                return PhotoBoothFile(image: image, pencilData: PencilData())
//            } else {
//                do {
//                    let data = try Data(contentsOf: selectedFilePath)
//                    return PhotoBoothFile(data: data)
//                } catch {
//                    NSAlert(error: error).runModal()
//                }
//            }
//        }
//        return nil
//    }

    func openSVGFile() -> XML.Accessor? {
        if openPanel.runModal() == .OK {
            guard let selectedFilePath: URL = openPanel.urls.first else { return nil }
            do {
                let data = try Data(contentsOf: selectedFilePath)
                return XML.parse(data)
            } catch {
                NSAlert(error: error).runModal()
            }
        }
        return nil
    }

    func saveFile(_ photoBoothFile: PhotoBoothFile) {
        if savePanel.runModal() == .OK {

            guard let selectedDirectory: String = savePanel.directoryURL?.path else { return }

            let selectedExtension: FileExtension = FileExtension(rawValue: fileExtensionButton.selectedItem?.title ?? "png") ?? .png

                do {
                    switch selectedExtension {
                        case .svg:
                            let xml = photoBoothFile.pencilData?.getSVGString()
                            try xml?.data(using: .utf8)?.write(to: selectedDirectory, name: savePanel.nameFieldStringValue)
                        default:
                            try photoBoothFile.image.pngData?.write(to: selectedDirectory, name: savePanel.nameFieldStringValue)
                    }
                } catch {
                    NSAlert(error: error).runModal()
                }
        }
    }
}
