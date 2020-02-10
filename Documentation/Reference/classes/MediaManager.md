**CLASS**

# `MediaManager`

```swift
class MediaManager
```

> Singleton class to open and save files

## Properties
### `savePanel`

```swift
private lazy var savePanel: NSSavePanel =
```

### `openPanel`

```swift
private lazy var openPanel: NSOpenPanel =
```

### `fileExtensionButton`

```swift
private lazy var fileExtensionButton: NSPopUpButton =
```

## Methods
### `selectedExtensionChanged(_:)`

```swift
@objc private func selectedExtensionChanged(_ sender: NSPopUpButton)
```

### `openFile()`

```swift
func openFile() -> PhotoBoothFile?
```

### `saveFile(_:)`

```swift
func saveFile(_ photoBoothFile: PhotoBoothFile) -> URL?
```

### `getPhotoBoothFileFrom(_:)`

```swift
func getPhotoBoothFileFrom(_ photoBoothFileURL: URL) -> PhotoBoothFile?
```

> Loads package contents from a .photobooth directory or loads a png file

### `savePhotoBoothFile(_:to:)`

```swift
func savePhotoBoothFile(_ photoBoothFile: PhotoBoothFile, to url: URL) -> URL?
```

> Saves PhotoBoothFile in a .png or a .photobooth package file, returns the URL path
