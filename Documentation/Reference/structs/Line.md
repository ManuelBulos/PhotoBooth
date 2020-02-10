**STRUCT**

# `Line`

```swift
struct Line: Equatable
```

> Drawing Line

## Properties
### `points`

```swift
var points: [CGPoint]
```

### `color`

```swift
let color: NSColor
```

### `width`

```swift
let width: CGFloat
```

## Methods
### `init(points:color:width:)`

```swift
init(points: [CGPoint], color: NSColor, width: CGFloat)
```

### `init(polyline:canvasHeight:)`

```swift
init?(polyline: AEXMLElement, canvasHeight: Float)
```

### `drawInCurrentContext()`

```swift
func drawInCurrentContext()
```

> Draws line in the current NSGraphicsContext
