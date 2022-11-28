## Flutter Onboard Package

## Features

Easy customization your own style

## Getting started

Add the package to your pubspec.yaml file

`flutter pub add flutter_onboard`

in your dart file, import the library

```dart
import 'package/flutter_onboard/flutter_onboard';
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var number = "";
    return MaterialApp(
      home: Scaffold(
          body: OnBoarding(
              numberOfPages: 3,
              currentPage: 1,
              doneButton: () {

              },
              title: "Test",
              body: "Test Body",
              image: "logo" // images can be added to assets in pubspec.yaml  and only .png files
          )
      ),
    );
  }
}
```

## Parameters

`indicatorActiveColor` it shows which page can be hold to highlight, wish you change the active
color use the parameter
`indiacatorDeActiveColor` it shows which page can be not selected to highlight, wish you change the
active color use the parameter

## Additional information

TODO: Tell users more about the package: where to find more information, how to contribute to the
package, how to file issues, what response they can expect from the package authors, and more.
