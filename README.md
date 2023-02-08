
[![License][license-image]][license-url]
[![Swift Version][swift-image]][swift-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](https://www.apple.com)

# RecipeApp

Application for finding and saving your recipes. Selection of recipes is possible by category. When opening a recipe card, the user can see: a photo of the finished product, the time spent on cooking, the number of servings, a description of the recipe, a list of ingredients for the recipe, the nutritional value of the finished product, step-by-step cooking instructions. The FirebaseAuth authentication service is used to register the user. The application has the ability to recover the password by sending a letter to the mail that was used when registering in the application. After registering with an email address in the FirebaseAuth authentication system, the user has the opportunity to save their recipes for a more convenient interaction with them. Saved recipes by the user are visible only to him and are not automatically published to the public catalog. The application is written using the MVVM pattern and the SwiftUI framework.

![GifAccount][gif-account-url]
![Gif][gif-url]

## Features

- [x] Entirely written in SwiftUI
- [x] Designed using the MVVM pattern
- [x] Used generics
- [x] Use Grand Central Dispatch
- [x] Use FirebaseAuth register users
- [x] Use FirebaseFirestore to store recipes
- [x] Use FirebaseFirestore to store users recipes
- [x] Detailed view of the recipe contains: photo of the finished product, cooking time, number of servings, description of the recipe, list of ingredients for the recipe, nutritional value of the finished product, step-by-step cooking instructions.

## Requirements

- iOS 15.5+
- Xcode 13.4.1

## Installation

#### Swift Package Manager
Project use Swift Package Manager to install dependencies: `FirebaseAuth`, `FirebaseDatabase`, `FirebaseFirestore`, `FirebaseStorage`

#### OR

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `FirebaseCore`, `FirebaseAuth`, `FirebaseDatabase`, `FirebaseFirestore`, `FirebaseStorage` by adding it to your `Podfile`:

1. If you use CocoaPods please delete installed frameworks with Swift Package Manager RecipeApp -> Targets -> Frameworks, Libraries, and Embedded Component

2. Create a Podfile if you don't already have one. From the root of your project directory, run the following command: `pod init`

3. To your Podfile, add the Firebase pods:

```swift
platform :ios, '15.5'
pod 'FirebaseCore'
pod 'FirebaseAuth'
pod 'FirebaseDatabase'
pod 'FirebaseFirestore'
pod 'FirebaseStorage'
```

4. Install the pods, then open your .xcworkspace file to see the project in Xcode: `pod install --repo-update`

5. Open: RecipeApp.xcworkspace

## Meta

Link to used icons: 

1. https://www.flaticon.com/free-icon/user_1177568?term=user&page=1&position=20&page=1&position=20&related_id=1177568&origin=search

2. https://www.flaticon.com/free-icon/cross_2763138?related_id=2763138&origin=search

3. https://www.flaticon.com/free-icon/multiply_7378386?related_id=7378386&origin=search


Distributed under the GPL-2.0 license. See ``LICENSE`` for more information.

[https://github.com/TwinkleFoxy/github-link](https://github.com/TwinkleFoxy/)

[swift-image]: https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-url]: https://github.com/TwinkleFoxy/RecipeApp/blob/main/LICENSE
[license-image]: https://img.shields.io/github/license/TwinkleFoxy/RecipeApp?color=brightgreen
[license-url]: https://github.com/TwinkleFoxy/RecipeApp/blob/main/LICENSE
[gif-url]: https://github.com/TwinkleFoxy/RecipeApp/blob/main/GIF/GIF.gif
[gif-account-url]: https://github.com/TwinkleFoxy/RecipeApp/blob/main/GIF/GIFAccount.gif
