**CLASS**

# `ImageEditorView`

```swift
class ImageEditorView: NSView
```

> NSView that holds a Canvas above an NSImageView

## Properties
### `imageView`

```swift
private lazy var imageView: NSImageView =
```

### `canvas`

```swift
private lazy var canvas: Canvas =
```

### `svgString`

```swift
var svgString: String
```

> SVG XML data

## Methods
### `init(frame:)`

```swift
override init(frame frameRect: NSRect)
```

### `init(coder:)`

```swift
required init?(coder: NSCoder)
```

### `commonInit()`

```swift
private func commonInit()
```

### `layout()`

```swift
override func layout()
```

### `setPhotoBoothFile(_:)`

```swift
func setPhotoBoothFile(_ photoBoothFile: PhotoBoothFile)
```

> Sets the PhotoBoothFile

### `getPhotoBoothFile()`

```swift
func getPhotoBoothFile() -> PhotoBoothFile?
```

> Returns an PhotoBoothFile

### `imageWithDrawings()`

```swift
func imageWithDrawings() -> NSImage
```

> Returns an NSImage containing all the drawings

### `openColorPicker()`

```swift
func openColorPicker()
```

> Shows an NSColorPanel window

### `closeColorPicker()`

```swift
func closeColorPicker()
```

> Dismisses an NSColorPanel window

### `setLineWidth(_:)`

```swift
func setLineWidth(_ width: CGFloat)
```

> Sets the width of the line stroke in the canvas

### `clearCanvas()`

```swift
func clearCanvas()
```

> Removes all drawings from the canvas

### `undo()`

```swift
func undo()
```

> Removes last continuous line from the canvas
