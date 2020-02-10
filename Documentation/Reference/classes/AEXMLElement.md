**CLASS**

# `AEXMLElement`

```swift
open class AEXMLElement
```

> This is base class for holding XML structure.
>
> You can access its structure by using subscript like this: `element["foo"]["bar"]` which would
> return `<bar></bar>` element from `<element><foo><bar></bar></foo></element>` XML as an `AEXMLElement` object.

## Properties
### `parent`

```swift
open internal(set) weak var parent: AEXMLElement?
```

> Every `AEXMLElement` should have its parent element instead of `AEXMLDocument` which parent is `nil`.

### `children`

```swift
open internal(set) var children = [AEXMLElement]()
```

> Child XML elements.

### `name`

```swift
open var name: String
```

> XML Element name.

### `value`

```swift
open var value: String?
```

> XML Element value.

### `attributes`

```swift
open var attributes: [String : String]
```

> XML Element attributes.

### `error`

```swift
open var error: AEXMLError?
```

> Error value (`nil` if there is no error).

### `string`

```swift
open var string: String
```

> String representation of `value` property (if `value` is `nil` this is empty String).

### `bool`

```swift
open var bool: Bool?
```

> Boolean representation of `value` property (`nil` if `value` can't be represented as Bool).

### `int`

```swift
open var int: Int?
```

> Integer representation of `value` property (`nil` if `value` can't be represented as Integer).

### `double`

```swift
open var double: Double?
```

> Double representation of `value` property (`nil` if `value` can't be represented as Double).

### `all`

```swift
open var all: [AEXMLElement]?
```

> Returns all of the elements with equal name as `self` **(nil if not exists)**.

### `first`

```swift
open var first: AEXMLElement?
```

> Returns the first element with equal name as `self` **(nil if not exists)**.

### `last`

```swift
open var last: AEXMLElement?
```

> Returns the last element with equal name as `self` **(nil if not exists)**.

### `count`

```swift
open var count: Int
```

> Returns number of all elements with equal name as `self`.

### `xml`

```swift
open var xml: String
```

> Complete hierarchy of `self` and `children` in **XML** escaped and formatted String

### `xmlCompact`

```swift
open var xmlCompact: String
```

> Same as `xmlString` but without `\n` and `\t` characters

### `xmlSpaces`

```swift
open var xmlSpaces: String
```

> Same as `xmlString` but with 4 spaces instead '\t' characters

### `parentsCount`

```swift
private var parentsCount: Int
```

## Methods
### `init(name:value:attributes:)`

```swift
public init(name: String, value: String? = nil, attributes: [String : String] = [:])
```

> Designated initializer - all parameters are optional.
>
> - parameter name: XML element name.
> - parameter value: XML element value (defaults to `nil`).
> - parameter attributes: XML element attributes (defaults to empty dictionary).
>
> - returns: An initialized `AEXMLElement` object.

#### Parameters

| Name | Description |
| ---- | ----------- |
| name | XML element name. |
| value | XML element value (defaults to `nil`). |
| attributes | XML element attributes (defaults to empty dictionary). |

### `all(withValue:)`

```swift
open func all(withValue value: String) -> [AEXMLElement]?
```

> Returns all elements with given value.
>
> - parameter value: XML element value.
>
> - returns: Optional Array of found XML elements.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | XML element value. |

### `all(containingAttributeKeys:)`

```swift
open func all(containingAttributeKeys keys: [String]) -> [AEXMLElement]?
```

> Returns all elements containing given attributes.
>
> - parameter attributes: Array of attribute names.
>
> - returns: Optional Array of found XML elements.

#### Parameters

| Name | Description |
| ---- | ----------- |
| attributes | Array of attribute names. |

### `all(withAttributes:)`

```swift
open func all(withAttributes attributes: [String : String]) -> [AEXMLElement]?
```

> Returns all elements with given attributes.
>
> - parameter attributes: Dictionary of Keys and Values of attributes.
>
> - returns: Optional Array of found XML elements.

#### Parameters

| Name | Description |
| ---- | ----------- |
| attributes | Dictionary of Keys and Values of attributes. |

### `allDescendants(where:)`

```swift
open func allDescendants(where predicate: (AEXMLElement) -> Bool) -> [AEXMLElement]
```

> Returns all descendant elements which satisfy the given predicate.
>
> Searching is done vertically; children are tested before siblings. Elements appear in the list
> in the order in which they are found.
>
> - parameter predicate: Function which returns `true` for a desired element and `false` otherwise.
>
> - returns: Array of found XML elements.

#### Parameters

| Name | Description |
| ---- | ----------- |
| predicate | Function which returns `true` for a desired element and `false` otherwise. |

### `firstDescendant(where:)`

```swift
open func firstDescendant(where predicate: (AEXMLElement) -> Bool) -> AEXMLElement?
```

> Returns the first descendant element which satisfies the given predicate, or nil if no such element is found.
>
> Searching is done vertically; children are tested before siblings.
>
> - parameter predicate: Function which returns `true` for the desired element and `false` otherwise.
>
> - returns: Optional AEXMLElement.

#### Parameters

| Name | Description |
| ---- | ----------- |
| predicate | Function which returns `true` for the desired element and `false` otherwise. |

### `hasDescendant(where:)`

```swift
open func hasDescendant(where predicate: (AEXMLElement) -> Bool) -> Bool
```

> Indicates whether the element has a descendant satisfying the given predicate.
>
> - parameter predicate: Function which returns `true` for the desired element and `false` otherwise.
>
> - returns: Bool.

#### Parameters

| Name | Description |
| ---- | ----------- |
| predicate | Function which returns `true` for the desired element and `false` otherwise. |

### `addChild(_:)`

```swift
open func addChild(_ child: AEXMLElement) -> AEXMLElement
```

> Adds child XML element to `self`.
>
> - parameter child: Child XML element to add.
>
> - returns: Child XML element with `self` as `parent`.

#### Parameters

| Name | Description |
| ---- | ----------- |
| child | Child XML element to add. |

### `addChild(name:value:attributes:)`

```swift
open func addChild(name: String,
                   value: String? = nil,
                   attributes: [String : String] = [:]) -> AEXMLElement
```

> Adds child XML element to `self`.
>
> - parameter name: Child XML element name.
> - parameter value: Child XML element value (defaults to `nil`).
> - parameter attributes: Child XML element attributes (defaults to empty dictionary).
>
> - returns: Child XML element with `self` as `parent`.

#### Parameters

| Name | Description |
| ---- | ----------- |
| name | Child XML element name. |
| value | Child XML element value (defaults to `nil`). |
| attributes | Child XML element attributes (defaults to empty dictionary). |

### `addChildren(_:)`

```swift
open func addChildren(_ children: [AEXMLElement]) -> [AEXMLElement]
```

> Adds an array of XML elements to `self`.
>
> - parameter children: Child XML element array to add.
>
> - returns: Child XML elements with `self` as `parent`.

#### Parameters

| Name | Description |
| ---- | ----------- |
| children | Child XML element array to add. |

### `removeFromParent()`

```swift
open func removeFromParent()
```

> Removes `self` from `parent` XML element.

### `indent(withDepth:)`

```swift
private func indent(withDepth depth: Int) -> String
```
