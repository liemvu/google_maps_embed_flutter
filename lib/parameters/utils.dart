import 'package:google_maps_embed_flutter/parameters/parameters.dart';

extension CoordinatesUtils on Coordinates {
  /// Returns the string representation of the latitude and longitude.
  ///
  /// The returned string is in the format "latitude,longitude".
  String get stringValue {
    return "$latitude,$longitude";
  }
}
