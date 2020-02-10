**CLASS**

# `PencilData`

```swift
class PencilData
```

> Data from the Drawing canvas

## Properties
### `lines`

```swift
private(set) var lines: [Line] = [Line]()
```

> All drawing is stored in a collection of lines.
> Each Line object stores an array of CGPoints

### `canvasSize`

```swift
private(set) var canvasSize: CGSize?
```

> Stores the CGSize of the canvas

### `isEmpty`

```swift
var isEmpty: Bool
```

> Returns true if lines array is empty

## Methods
### `init()`

```swift
init()
```

### `init(xml:)`

```swift
init(xml: AEXMLDocument)
```

### `addLine(_:)`

```swift
func addLine(_ line: Line)
```

> Adds a new line to the array

### `popLastLine()`

```swift
func popLastLine()
```

> Pops last line

### `removeAllLines()`

```swift
func removeAllLines()
```

> Removes all lines

### `drawInCurrentContext()`

```swift
func drawInCurrentContext()
```

> Draws lines in the current NSGraphicsContext

### `addPointToLastLine(_:)`

```swift
func addPointToLastLine(_ point: NSPoint)
```

> Appends new NSPoint

### `setCanvasSize(_:)`

```swift
func setCanvasSize(_ size: CGSize)
```

> Stores the size of the working canvas

### `getSVGString(size:)`

```swift
func getSVGString(size: CGSize? = nil) -> String
```

> Returns svg xml string, if size is nil, it takes the working canvas size
