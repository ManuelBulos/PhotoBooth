**CLASS**

# `AEXMLDocument`

```swift
open class AEXMLDocument: AEXMLElement
```

> This class is inherited from `AEXMLElement` and has a few addons to represent **XML Document**.
>
> XML Parsing is also done with this object.

## Properties
### `root`

```swift
open var root: AEXMLElement
```

> Root (the first child element) element of XML Document **(Empty element with error if not exists)**.

### `options`

```swift
public let options: AEXMLOptions
```

### `xml`

```swift
open override var xml: String
```

> Override of `xml` property of `AEXMLElement` - it just inserts XML Document header at the beginning.

## Methods
### `init(root:options:)`

```swift
public init(root: AEXMLElement? = nil, options: AEXMLOptions = AEXMLOptions())
```

> Designated initializer - Creates and returns new XML Document object.
>
> - parameter root: Root XML element for XML Document (defaults to `nil`).
> - parameter options: Options for XML Document header and parser settings (defaults to `AEXMLOptions()`).
>
> - returns: Initialized XML Document object.

#### Parameters

| Name | Description |
| ---- | ----------- |
| root | Root XML element for XML Document (defaults to `nil`). |
| options | Options for XML Document header and parser settings (defaults to `AEXMLOptions()`). |

### `init(xml:options:)`

```swift
public convenience init(xml: Data, options: AEXMLOptions = AEXMLOptions()) throws
```

> Convenience initializer - used for parsing XML data (by calling `loadXMLData:` internally).
>
> - parameter xmlData: XML data to parse.
> - parameter options: Options for XML Document header and parser settings (defaults to `AEXMLOptions()`).
>
> - returns: Initialized XML Document object containing parsed data. Throws error if data could not be parsed.

#### Parameters

| Name | Description |
| ---- | ----------- |
| xmlData | XML data to parse. |
| options | Options for XML Document header and parser settings (defaults to `AEXMLOptions()`). |

### `init(xml:encoding:options:)`

```swift
public convenience init(xml: String,
                        encoding: String.Encoding = String.Encoding.utf8,
                        options: AEXMLOptions = AEXMLOptions()) throws
```

> Convenience initializer - used for parsing XML string (by calling `init(xmlData:options:)` internally).
>
> - parameter xmlString: XML string to parse.
> - parameter encoding: String encoding for creating `Data` from `xmlString` (defaults to `String.Encoding.utf8`)
> - parameter options: Options for XML Document header and parser settings (defaults to `AEXMLOptions()`).
>
> - returns: Initialized XML Document object containing parsed data. Throws error if data could not be parsed.

#### Parameters

| Name | Description |
| ---- | ----------- |
| xmlString | XML string to parse. |
| encoding | String encoding for creating `Data` from `xmlString` (defaults to `String.Encoding.utf8`) |
| options | Options for XML Document header and parser settings (defaults to `AEXMLOptions()`). |

### `loadXML(_:)`

```swift
open func loadXML(_ data: Data) throws
```

> Creates instance of `AEXMLParser` (private class which is simple wrapper around `XMLParser`)
> and starts parsing the given XML data. Throws error if data could not be parsed.
>
> - parameter data: XML which should be parsed.

#### Parameters

| Name | Description |
| ---- | ----------- |
| data | XML which should be parsed. |