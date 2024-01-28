
# GSProgressBar

This project came about when I needed a progress bar, and when looking for one, I didn't stumble upon a progress bar that gave me a "plug and play" functionality that updated me on it's current progress.... 

So I made one!

## Authors

- [@GravesScout](https://github.com/GravesScout)


## Usage
### This is how to use a configured `GSProgressBar`

`type` - value from `GSProgressBarType` enum.<br>
`animationType` - value from `GSAnimationType` enum.<br>
`trackLineWidth` - a `CGFloat` to tell the track lineWidth.<br>
`fillLineWidth` - a `CGFloat` to tell the progress bar fill lineWidth.<br>
`play` - a boolean to play or pause the progression.<br>

```swift
GSProgressBar(type: progressType,
              animationType: animationType,
              trackLineWidth: trackLineWidth,
              fillLineWidth: fillLineWidth,
              showShadow: true,
              play: $play) { currentProgress in
                    progress = currentProgress
                }.frame(width: 150, height: 150)
```

### This is how to use a manual `GSProgressBar`

`animationType` - value from `GSAnimationType` enum.<br>
`trackLineWidth` - a `CGFloat` to tell the track lineWidth.<br>
`fillLineWidth` - a `CGFloat` to tell the progress bar fill lineWidth.<br>
`progress` - Binding of `CGFloat` for the progress.<br>

```swift
 GSManualProgressBar(type: progressType,
                     trackLineWidth: trackLineWidth,
                     fillLineWidth: fillLineWidth,
                     showShadow: true,
                     progress: $progress)
                .frame(width: 150)
```

## Types
### `GSProgressBarType` enum:
```
`bar` - A line progress bar.
`circular` - A circle progress bar.
`customPath` - A customPath progress bar, has a path property that needs to be provided.
```

### `GSAnimationType` enum:
```
`linear` - Has a constant duration, goes from 0 to 100%.
`sectioned` - Creates pre-defined sections according to provided `GSProgressSectionMetadata` array.
`randomized` - Creates randomized sections according to provided `GSRandomizedConfiguration`.
```
### `GSRandomizedDelay` enum:
```
`noDelay` - No delay between sections.
`constantDelay` - Has the same provided delay between each section.
`randomizedDelay` - Has a random delay between each section, configured by the provided `ClosedRange<CGFloat>`.
```

### `GSProgressSectionMetadata` struct:
```
`duration` - This section duration of animation.
`sectionProportionValue` - The section portion (needs to be additive inside the array).
`sectionDelay` - The delay in between the sections.
```

### `GSRandomizedConfiguration` struct:
```
`sectionsRange` - A `ClosedRange<Int>` that is the base for the random number of sections.
`durationRange` - A `ClosedRange<Double>` that is the base for the random duration of each section.
`sectionsDelay` - `GSRandomizedDelay` to configure the delay between sections.
```
## Examples
### <ins>A linear duration bar type progress bar:</ins>
```swift
GSProgressBar(type: .bar,
              animationType: .linear(duration: 4.25),
              trackLineWidth: trackLineWidth,
              fillLineWidth: fillLineWidth,
              showShadow: true,
              play: $play)
```

### <ins>A sectioned circular type progress bar:</ins>
```swift
GSProgressBar(type: .circular,
              animationType: .sectioned(
                  sections: [
                      GSProgressSectionMetadata(duration: 3, sectionProportionValue: 0.3, sectionDelay: 2),
                      GSProgressSectionMetadata(duration: 1.5, sectionProportionValue: 0.6, sectionDelay: 4),
                      GSProgressSectionMetadata(duration: 5, sectionProportionValue: 0.1)]),
              trackLineWidth: trackLineWidth,
              fillLineWidth: fillLineWidth,
              showShadow: true,
              play: $play)
```

### <ins>A randomized customPath type progress bar:</ins>
```swift
GSProgressBar(type: .customPath(path: .swiftLogo),
              animationType: .randomized(
                  configuration: .init(
                      sectionsRange: 5...8,
                      durationRange: 1...5,
                      sectionsDelay: GSRandomizedDelay.randomizedDelay(delayRange: 0.4...5))),
              trackLineWidth: trackLineWidth,
              fillLineWidth: fillLineWidth,
              showShadow: true,
              play: $play)
```
## Installation

Install my-project with npm

```swiftPackage
  dependencies: [
    .package(url: "https://github.com/GravesScout/GSProgressBar", from: "main")
]
```
    
## Requirements
* iOS 14+
