**CLASS**

# `CameraToolBar`

```swift
class CameraToolBar: NSView
```

> NSView with buttons for controlling the camera and a canvas

## Properties
### `stackView`

```swift
private lazy var stackView: NSStackView =
```

### `newFileButton`

```swift
private lazy var newFileButton: NSButton =
```

### `saveFileButton`

```swift
private lazy var saveFileButton: NSButton =
```

### `takeCameraSnapshotButton`

```swift
private lazy var takeCameraSnapshotButton: NSButton =
```

### `openFileButton`

```swift
private lazy var openFileButton: NSButton =
```

### `undoButton`

```swift
private lazy var undoButton: NSButton =
```

### `clearCanvasButton`

```swift
private lazy var clearCanvasButton: NSButton =
```

### `colorPickerButton`

```swift
private lazy var colorPickerButton: NSButton =
```

### `stackViewPadding`

```swift
private let stackViewPadding: CGFloat = 12
```

### `delegate`

```swift
weak var delegate: CameraToolBarDelegate?
```

## Methods
### `init(frame:hideEditingButtons:delegate:)`

```swift
init(frame: NSRect = .zero, hideEditingButtons: Bool = true, delegate: CameraToolBarDelegate)
```

### `init(coder:)`

```swift
required init?(coder: NSCoder)
```

### `commonInit(hideEditingButtons:)`

```swift
private func commonInit(hideEditingButtons: Bool = true)
```

### `updateConstraints()`

```swift
override func updateConstraints()
```

### `hideEditingButtons(_:)`

```swift
func hideEditingButtons(_ hideEditingButtons: Bool)
```

### `newFileButtonClicked()`

```swift
@objc private func newFileButtonClicked()
```

### `saveFileButtonClicked()`

```swift
@objc private func saveFileButtonClicked()
```

### `takeCameraSnapshotButtonClicked()`

```swift
@objc private func takeCameraSnapshotButtonClicked()
```

### `openFileButtonClicked()`

```swift
@objc private func openFileButtonClicked()
```

### `undoButtonClicked()`

```swift
@objc private func undoButtonClicked()
```

### `clearCanvasButtonClicked()`

```swift
@objc private func clearCanvasButtonClicked()
```

### `colorPickerButtonClicked()`

```swift
@objc private func colorPickerButtonClicked()
```
