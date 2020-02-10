**CLASS**

# `MainViewController`

```swift
class MainViewController: NSViewController
```

## Properties
### `stackView`

```swift
private lazy var stackView: NSStackView =
```

### `cameraPreview`

```swift
internal lazy var cameraPreview: CameraPreview =
```

### `cameraToolBar`

```swift
internal lazy var cameraToolBar: CameraToolBar =
```

### `imageEditorView`

```swift
internal lazy var imageEditorView: ImageEditorView =
```

### `newFileWarningAlert`

```swift
internal lazy var newFileWarningAlert: NSAlert =
```

### `mainViewAspectRatio`

```swift
private let mainViewAspectRatio: CGFloat = 1.35
```

## Methods
### `deinit`

```swift
deinit
```

### `viewDidLoad()`

```swift
override func viewDidLoad()
```

### `updateViewConstraints()`

```swift
override func updateViewConstraints()
```

### `onClickedPhotoBoothFile(_:)`

```swift
@objc private func onClickedPhotoBoothFile(_ sender: Notification)
```

### `showCameraPreview()`

```swift
internal func showCameraPreview()
```

> Shows the Camera Preview and hides the ImageEditorView

### `showImageEditorView(photoBoothFile:)`

```swift
internal func showImageEditorView(photoBoothFile: PhotoBoothFile)
```

> Shows the ImageEditorView and hides the Camera Preview

### `toggleHiddenViews(isEditing:)`

```swift
private func toggleHiddenViews(isEditing: Bool)
```

> Toggles isHidden properties for cameraPreview, imageEditorView and cameraToolBar buttons
