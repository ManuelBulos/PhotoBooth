**CLASS**

# `CameraPreview`

```swift
class CameraPreview: NSView
```

> NSView that holds an AVCaptureVideoPreviewLayer

## Properties
### `cameraView`

```swift
private lazy var cameraView: NSView =
```

### `previewLayer`

```swift
private var previewLayer = AVCaptureVideoPreviewLayer()
```

### `captureSession`

```swift
private lazy var captureSession: AVCaptureSession =
```

### `captureDevice`

```swift
private lazy var captureDevice: AVCaptureDevice? =
```

### `captureImageOutput`

```swift
private lazy var captureImageOutput: AVCaptureVideoDataOutput =
```

### `isMirrored`

```swift
private(set) var isMirrored: Bool = true
```

> Returns true if image is flipped, defaults to true

### `shouldCaptureSnapshot`

```swift
private var shouldCaptureSnapshot: Bool = false
```

> Toggled at takeSnapshot() and AVCaptureVideoDataOutputSampleBufferDelegate

### `delegate`

```swift
weak var delegate: CameraPreviewDelegate?
```

## Methods
### `init(frame:delegate:quality:isMirrored:)`

```swift
init(frame: NSRect = .zero, delegate: CameraPreviewDelegate, quality: AVCaptureSession.Preset = .photo, isMirrored: Bool = true)
```

### `init(coder:)`

```swift
required init?(coder: NSCoder)
```

### `commonInit(delegate:quality:isMirrored:)`

```swift
private func commonInit(delegate: CameraPreviewDelegate? = nil, quality: AVCaptureSession.Preset = .photo, isMirrored: Bool = true)
```

### `updateConstraints()`

```swift
override func updateConstraints()
```

### `layout()`

```swift
override func layout()
```

### `setVideoQuality(_:)`

```swift
func setVideoQuality(_ quality: AVCaptureSession.Preset)
```

> Configures the current AVCaptureSession Preset

### `flipPreview(isMirrored:)`

```swift
func flipPreview(isMirrored: Bool)
```

> Mirrors the preview

### `stopPreview()`

```swift
func stopPreview()
```

> Stops current AVCaptureSession

### `takeSnapshot()`

```swift
func takeSnapshot()
```

> Enables a snapshot from the current AVCaptureSession

### `startPreview(overrideCurrentSession:)`

```swift
func startPreview(overrideCurrentSession: Bool = false)
```

> Attempts to start a new AVCaptureSession if its NOT currently running OR it was chosen to override current session
