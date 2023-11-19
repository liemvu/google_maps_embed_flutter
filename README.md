# google_maps_embed_flutter

This is a Flutter plugin for embedding Google Maps in Flutter applications.

## Getting Started

To use this plugin, add `google_maps_embed_flutter` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

## Features

* Support map modes: place, view, directions, streetview, search.

## Usage

Here's a basic example of how to use the `google_maps_embed_flutter` plugin.

```dart
import 'package:google_maps_embed_flutter/google_maps_embed_flutter.dart';

EmbedGoogleMap(
    parameters: PlaceParameters(key: apiKey)
        ..q = "1600 Amphitheatre Parkway, Mountain View, CA 94043, United States",
    );
```
