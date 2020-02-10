**CLASS**

# `Canvas`

```swift
class Canvas: NSView
```

> NSView that supports drawing with the mouse

## Properties
### `pencilData`

```swift
private var pencilData: PencilData = PencilData()
```

> All drawing is stored in a collection of lines

### `undosCounter`

```swift
private var undosCounter: Int = 0
```

> Undos counter, starts at 0

### `undosLimit`

```swift
private var undosLimit: Int?
```

> Defaults to infinite

### `lineWidth`

```swift
var lineWidth: CGFloat = 10
```

> Width of the stroke, ddefaults to 10

### `lineColor`

```swift
var lineColor: NSColor
```

> NSColorPanel shared selected color

### `svgString`

```swift
var svgString: String
```

> SVG XML data

## Methods
### `init(undosLimit:)`

```swift
init(undosLimit: Int? = nil)
```

### `init(coder:)`

```swift
required init?(coder: NSCoder)
```

### `commonInit(undosLimit:)`

```swift
private func commonInit(undosLimit: Int? = nil)
```

### `draw(_:)`

```swift
override func draw(_ dirtyRect: NSRect)
```

### `mouseDown(with:)`

```swift
override func mouseDown(with event: NSEvent)
```

### `mouseDragged(with:)`

```swift
override func mouseDragged(with event: NSEvent)
```

### `layout()`

```swift
override func layout()
```

### `clear()`

```swift
func clear()
```

> Removes all drawings and restarts undos counter

### `undo()`

```swift
func undo()
```

> Removes last continuous line

### `setPencilData(_:)`

```swift
func setPencilData(_ pencilData: PencilData)
```

> Updates current rect and displays new drawings

### `getPencilData()`

```swift
func getPencilData() -> PencilData
```

> Returns current PencilData
