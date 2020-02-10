**ENUM**

# `AEXMLError`

```swift
public enum AEXMLError: Error
```

> A type representing error value that can be thrown or inside `error` property of `AEXMLElement`.

## Cases
### `elementNotFound`

```swift
case elementNotFound
```

> This will be inside `error` property of `AEXMLElement` when subscript is used for not-existing element.

### `rootElementMissing`

```swift
case rootElementMissing
```

> This will be inside `error` property of `AEXMLDocument` when there is no root element.

### `parsingFailed`

```swift
case parsingFailed
```

> `AEXMLDocument` can throw this error on `init` or `loadXMLData` if parsing with `XMLParser` was not successful.
