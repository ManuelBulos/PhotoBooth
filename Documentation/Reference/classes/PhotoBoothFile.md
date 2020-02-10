**CLASS**

# `PhotoBoothFile`

```swift
class PhotoBoothFile: NSDocument
```

> Object that stores all file types used in the app

## Properties
### `image`

```swift
var image: NSImage
```

> Unedited NSImage

### `pencilData`

```swift
var pencilData: PencilData?
```

> Drawings

### `imageWithPencilData`

```swift
var imageWithPencilData: NSImage?
```

> NSImage with drawing data

### `hasPencilData`

```swift
var hasPencilData: Bool
```

> returns true if user draw at least one line in the canvas

## Methods
### `init(image:pencilData:)`

```swift
init(image: NSImage, pencilData: PencilData? = nil)
```

### `setImageWithPencilData(_:)`

```swift
func setImageWithPencilData(_ image: NSImage)
```

> Stores the image with drawing data
