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
        case pdf
        case jpeg
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

    func saveImage(_ image: NSImage) {
        if savePanel.runModal() == .OK {
            guard let selectedDirectory: String = savePanel.directoryURL?.path else { return }
            do {
                try image.pngData?.write(to: selectedDirectory, name: savePanel.nameFieldStringValue)
            } catch {
                NSAlert(error: error).runModal()
            }
        }
    }

    func savePencilData(_ pdfData: Data) {
        if savePanel.runModal() == .OK {
            guard let selectedDirectory: String = savePanel.directoryURL?.path else { return }
            do {
                try pdfData.write(to: selectedDirectory, name: savePanel.nameFieldStringValue)
            } catch {
                NSAlert(error: error).runModal()
            }
        }
    }
}
