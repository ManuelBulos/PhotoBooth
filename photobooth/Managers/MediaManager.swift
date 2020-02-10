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

    // MARK: - UI Elements

    private lazy var savePanel: NSSavePanel = {
        let savePanel = NSSavePanel()
        savePanel.accessoryView = fileExtensionButton
        savePanel.allowedFileTypes = [String.FileExtension.png.stringValue]
        savePanel.allowsOtherFileTypes = false
        return savePanel
    }()

    private lazy var openPanel: NSOpenPanel = {
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = String.FileExtension.allCases.map({ $0.stringValue })
        openPanel.allowsMultipleSelection = true
        openPanel.allowsOtherFileTypes = true
        openPanel.canChooseDirectories = true
        return openPanel
    }()

    private lazy var fileExtensionButton: NSPopUpButton = {
        let fileExtensionButton = NSPopUpButton()
        fileExtensionButton.addItems(withTitles: String.FileExtension.allCases.map { $0.stringValue } )
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

    func openSVGFile() -> AEXMLDocument? {
        if openPanel.runModal() == .OK {
            guard let selectedFilePath: URL = openPanel.urls.first else { return nil }
            do {
                let data = try Data(contentsOf: selectedFilePath)
                return try AEXMLDocument(xml: data)
            } catch {
                NSAlert(error: error).runModal()
            }
        }
        return nil
    }

    func openFile() -> PhotoBoothFile? {
        if openPanel.runModal() == .OK {
            guard let selectedFilePathURL: URL = openPanel.urls.first else { return nil }

            var isDirectory: ObjCBool = false

            FileManager.default.fileExists(atPath: selectedFilePathURL.path, isDirectory: &isDirectory)

            if isDirectory.boolValue {
                let subPaths = FileManager.default.subpaths(atPath: selectedFilePathURL.path)

                guard
                    let imagePath = subPaths?.first(where: { (path) -> Bool in
                        return path.hasSuffix(String.FileExtension.png.stringValueWithDot)
                    }),

                    let svgPath = subPaths?.first(where: { (path) -> Bool in
                        return path.hasSuffix(String.FileExtension.svg.stringValueWithDot)
                    })

                    else { return nil }

                do {
                    // Image file
                    let fullImagePathURL: URL = selectedFilePathURL.appendingPathComponent(imagePath)
                    let imageData = try Data(contentsOf: fullImagePathURL)
                    guard let image = NSImage(data: imageData) else { return nil }

                    // SVG file
                    let fullSVGPathURL: URL = selectedFilePathURL.appendingPathComponent(svgPath)
                    let svgData = try Data(contentsOf: fullSVGPathURL)
                    let svgXML = try AEXMLDocument(xml: svgData)
                    let pencilData = PencilData(xml: svgXML)
                    return PhotoBoothFile(image: image, pencilData: pencilData)
                } catch {
                    NSAlert(error: error).runModal()
                }
            } else {
                do {
                    if selectedFilePathURL.pathExtension == String.FileExtension.png.stringValue {
                        let data = try Data(contentsOf: selectedFilePathURL)
                        guard let image = NSImage(data: data) else { return nil }
                        return PhotoBoothFile(image: image)
                    } else {
                        let svgData = try Data(contentsOf: selectedFilePathURL)
                        let svgXML = try AEXMLDocument(xml: svgData)
                        let pencilData = PencilData(xml: svgXML)
                        return PhotoBoothFile(image: NSImage(), pencilData: pencilData)
                    }
                } catch {
                    NSAlert(error: error).runModal()
                }
            }
        }
        return nil
    }

    func saveFile(_ photoBoothFile: PhotoBoothFile) {
        if savePanel.runModal() == .OK {

            guard
                let selectedDirectoryURL: URL = savePanel.directoryURL,
                let selectedExtensionTitle: String = fileExtensionButton.selectedItem?.title,
                let selectedExtension: String.FileExtension = String.FileExtension(rawValue: selectedExtensionTitle)
                else { return }

            let plainName: String = String(savePanel.nameFieldStringValue.split(separator: ".").first ?? "UntitledPhotoBoothFile")

                do {
                    switch selectedExtension {
                        case .photobooth:
                            let newDirectoryURL = selectedDirectoryURL.appendingPathComponent(plainName)
                            try FileManager.default.createDirectory(at: newDirectoryURL, withIntermediateDirectories: false, attributes: [:])
                            let xml = photoBoothFile.pencilData?.getSVGString()
                            try xml?.data(using: .utf8)?.write(to: newDirectoryURL.path, name: plainName.addExtension(.svg))
                            try photoBoothFile.image.pngData?.write(to: newDirectoryURL.path, name: plainName.addExtension(.png))
                        case .png:
                            try photoBoothFile.image.pngData?.write(to: selectedDirectoryURL.path, name: savePanel.nameFieldStringValue)
                        case .svg:
                            let xml = photoBoothFile.pencilData?.getSVGString()
                            try xml?.data(using: .utf8)?.write(to: selectedDirectoryURL.path, name: plainName.addExtension(.svg))
                    }
                } catch {
                    NSAlert(error: error).runModal()
                }
        }
    }
}
