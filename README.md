# PhotoBooth
MacOS App Coding Exercise

## Install
Download the project or run:
```console
$ git clone https://github.com/ManuelBulos/PhotoBooth.git
```

## Run
Open photobooth.xcodeproj and hit run


After capturing a snapshot you'll be presented with the editing window:

![Editing](/photobooth/Res/editing.png?raw=true)

When you are finished editing you can choose to save your work as .png or a .photobooth file.
If you choose .photobooth you can open up that file again and keep editing (undoing previous drawings and drawing new lines)

![Saving](/photobooth/Res/saving.png?raw=true)

## Technologies used
### Native
[AVFoundation](https://developer.apple.com/av-foundation/) used for previewing computer's camera.

[CoreGraphics](https://developer.apple.com/documentation/coregraphics/cgcontext) used to handle path-based drawing

### Third Parties
[AEXML](https://github.com/tadija/AEXML) lightweight XML parsing.
helps photobooth read polylines from svg files previously created using CGPoint arrays

## PhotoBooth Document (.photobooth package)
The .photobooth extension is a [UTI](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/understanding_utis/understand_utis_declare/understand_utis_declare.html)

Mac apps can add new uniform type identifiers for proprietary data formats. You declare new UTIs in the information property list (info.plist) file of a bundle.

This means that .photobooth is a directory (package) that contains 2 files: 
- the image in a .png format
- the .svg file created from the CGPoints drawn inside the CGContext

This way we can open the png image, then parse the svg into an array of CGPoints and draw them again on top of that image.

I chose svg format because it's very easy to generate an XML file (SVG) from a given collection of CGPoints, we just need to map the x and y of each point to a [polyline element](https://www.w3schools.com/graphics/svg_polyline.asp) on the XML File.

## Unit Testing
To run the unit tests just Open photobooth.xcodeproj and select the class photoboothTests in the [photoboothTests.swift](/photoboothTests/photoboothTests.swift) file

## Docs Reference
You can find more info about the project in the [documentation](/Documentation/Reference/README.md)
