//
//  MediaManager.swift
//  photobooth
//
//  Created by Manuel on 2/7/20.
//  Copyright © 2020 manuelbulos. All rights reserved.
//

import Cocoa
import Quartz

/// Singleton class to open and save files
class MediaManager {

    // MARK: - UI Elements

    private lazy var savePanel: NSSavePanel = {
        let savePanel = NSSavePanel()
        savePanel.accessoryView = fileExtensionButton
        savePanel.allowedFileTypes = SaveFileExtension.allCases.map({ $0.rawValue })
        savePanel.allowsOtherFileTypes = false
        return savePanel
    }()

    private lazy var openPanel: NSOpenPanel = {
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = OpenFileExtension.allCases.map({ $0.rawValue })
        openPanel.canChooseDirectories = true
        return openPanel
    }()

    private lazy var fileExtensionButton: NSPopUpButton = {
        let fileExtensionButton = NSPopUpButton()
        fileExtensionButton.addItems(withTitles: SaveFileExtension.allCases.map { $0.rawValue } )
        fileExtensionButton.action = #selector(selectedExtensionChanged)
        fileExtensionButton.target = self
        return fileExtensionButton
    }()

    // MARK: - Public Properties

    /// Singleton
    static var shared: MediaManager = MediaManager()

    // MARK: - Functions

    @objc private func selectedExtensionChanged(_ sender: NSPopUpButton) {
        guard let selectedExtension = sender.selectedItem?.title else { return }
        savePanel.allowedFileTypes = [selectedExtension]
    }

    func openFile() -> PhotoBoothFile? {
        if openPanel.runModal() == .OK {
            guard let selectedFilePathURL: URL = openPanel.urls.first else { return nil }
            return self.getPhotoBoothFileFrom(selectedFilePathURL)
        }
        return nil
    }

    @discardableResult
    func saveFile(_ photoBoothFile: PhotoBoothFile) -> URL? {
        if savePanel.runModal() == .OK {
            guard let selectedDirectoryURL: URL = savePanel.directoryURL else { return nil }
            return self.savePhotoBoothFile(photoBoothFile, to: selectedDirectoryURL)
        }
        return nil
    }

    /// Loads package contents from a .photobooth directory or loads a png file
    func getPhotoBoothFileFrom(_ photoBoothFileURL: URL) -> PhotoBoothFile? {

        var url: URL = photoBoothFileURL

        if !photoBoothFileURL.absoluteString.contains("file://") {
            if let newURL = URL(string: "file://")?.appendingPathComponent(photoBoothFileURL.absoluteString) {
                url = newURL
            }
        }

        var isDirectory: ObjCBool = false

        FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)

        if isDirectory.boolValue {
            let subPaths = FileManager.default.subpaths(atPath: url.path)

            guard
                let imagePath = subPaths?.first(where: { (path) -> Bool in
                    return path.hasSuffix(OpenFileExtension.png.string)
                }),

                let svgPath = subPaths?.first(where: { (path) -> Bool in
                    return path.hasSuffix(OpenFileExtension.svg.string)
                })

                else { return nil }

            do {
                // Image file
                let fullImagePathURL: URL = url.appendingPathComponent(imagePath)
                let imageData = try Data(contentsOf: fullImagePathURL)
                let image = NSImage(data: imageData) ?? NSImage()

                // SVG file
                let fullSVGPathURL: URL = url.appendingPathComponent(svgPath)
                let svgData = try Data(contentsOf: fullSVGPathURL)
                let svgXML = try AEXMLDocument(xml: svgData)
                let pencilData = PencilData(xml: svgXML)
                return PhotoBoothFile(image: image, pencilData: pencilData)
            } catch {
                NSAlert(error: error).runModal()
            }
        } else {
            do {
                if url.pathExtension == OpenFileExtension.png.rawValue {
                    let data = try Data(contentsOf: url)
                    let image = NSImage(data: data) ?? NSImage()
                    return PhotoBoothFile(image: image)
                } else {
                    let svgData = try Data(contentsOf: url)
                    let svgXML = try AEXMLDocument(xml: svgData)
                    let pencilData = PencilData(xml: svgXML)
                    return PhotoBoothFile(image: NSImage(), pencilData: pencilData)
                }
            } catch {
                NSAlert(error: error).runModal()
            }
        }
        return nil
    }

    /// Saves PhotoBoothFile in a .png or a .photobooth package file, returns the URL path
    func savePhotoBoothFile(_ photoBoothFile: PhotoBoothFile, to url: URL) -> URL? {
        guard
            let selectedExtensionTitle: String = fileExtensionButton.selectedItem?.title,
            let selectedExtension: SaveFileExtension = SaveFileExtension(rawValue: selectedExtensionTitle)
            else { return nil }

        let plainName: String = String(savePanel.nameFieldStringValue.split(separator: ".").first ?? "UntitledPhotoBoothFile")

        do {
            switch selectedExtension {
                case .photobooth:
                    // Create .photobooth directory
                    let newDirectoryURL = url.appendingPathComponent(plainName).appendingPathExtension(SaveFileExtension.photobooth.rawValue)
                    try FileManager.default.createDirectory(at: newDirectoryURL,
                                                            withIntermediateDirectories: false,
                                                            attributes: [:])
                    // Create svg file inside new directory
                    let xml = photoBoothFile.pencilData?.getSVGString()
                    try xml?.data(using: .utf8)?.write(to: newDirectoryURL.path, name: plainName.addExtension(OpenFileExtension.svg))

                    // Create png file inside new directory
                    try photoBoothFile.image.pngData?.write(to: newDirectoryURL.path, name: plainName.addExtension(OpenFileExtension.png))

                    return newDirectoryURL
                case .png:
                    if photoBoothFile.hasPencilData {
                        // Create png file from the image with pencil data
                        try photoBoothFile.imageWithPencilData?.pngData?.write(to: url.path, name: savePanel.nameFieldStringValue)
                    } else {
                        // create png file
                        try photoBoothFile.image.pngData?.write(to: url.path, name: savePanel.nameFieldStringValue)
                    }
                    return url.appendingPathComponent(savePanel.nameFieldStringValue)
            }
        } catch {
            NSAlert(error: error).runModal()
        }

        return nil
    }
}
