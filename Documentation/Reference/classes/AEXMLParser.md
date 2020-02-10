**CLASS**

# `AEXMLParser`

```swift
internal class AEXMLParser: NSObject, XMLParserDelegate
```

> Simple wrapper around `Foundation.XMLParser`.

## Properties
### `document`

```swift
let document: AEXMLDocument
```

### `data`

```swift
let data: Data
```

### `currentParent`

```swift
var currentParent: AEXMLElement?
```

### `currentElement`

```swift
var currentElement: AEXMLElement?
```

### `currentValue`

```swift
var currentValue = String()
```

### `parseError`

```swift
var parseError: Error?
```

### `parserSettings`

```swift
private lazy var parserSettings: AEXMLOptions.ParserSettings =
```

## Methods
### `init(document:data:)`

```swift
init(document: AEXMLDocument, data: Data)
```

### `parse()`

```swift
func parse() throws
```

### `parser(_:didStartElement:namespaceURI:qualifiedName:attributes:)`

```swift
func parser(_ parser: XMLParser,
            didStartElement elementName: String,
            namespaceURI: String?,
            qualifiedName qName: String?,
            attributes attributeDict: [String : String])
```

### `parser(_:foundCharacters:)`

```swift
func parser(_ parser: XMLParser, foundCharacters string: String)
```

### `parser(_:didEndElement:namespaceURI:qualifiedName:)`

```swift
func parser(_ parser: XMLParser,
            didEndElement elementName: String,
            namespaceURI: String?,
            qualifiedName qName: String?)
```

### `parser(_:parseErrorOccurred:)`

```swift
func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
```
