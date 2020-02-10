**EXTENSION**

# `MainViewController`

## Methods
### `didEncounterError(_:)`

```swift
func didEncounterError(_ error: Error)
```

### `didTakeSnapshot(_:)`

```swift
func didTakeSnapshot(_ snapshot: NSImage)
```

### `newFileButtonClicked()`

```swift
func newFileButtonClicked()
```

> Shows warning about losing all changes, if accepted it will take you back to the camera preview

### `saveFileButtonClicked()`

```swift
func saveFileButtonClicked()
```

> Tries to save current file

### `takeCameraSnapshotButtonClicked()`

```swift
func takeCameraSnapshotButtonClicked()
```

> Captures a still image from the current AVCapture Session

### `openFileButtonClicked()`

```swift
func openFileButtonClicked()
```

> Opens photobooth file selected by user

### `undoButtonClicked()`

```swift
func undoButtonClicked()
```

> Undos last continuous pencil strike

### `clearCanvasButtonClicked()`

```swift
func clearCanvasButtonClicked()
```

> Shows warning about losing all changes, if accepted it will clear all drawings from canvas

### `colorPickerButtonClicked()`

```swift
func colorPickerButtonClicked()
```

> Presents new window with a color picker
