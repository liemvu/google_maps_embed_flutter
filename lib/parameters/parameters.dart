import 'package:flutter/foundation.dart';
import 'package:google_maps_embed_flutter/parameters/utils.dart';

/// Enum representing different modes for the Google Maps widget.
///
/// The available modes are:
/// - `place`: Used to display a specific place on the map.
/// - `view`: Used to display a general view of the map.
/// - `directions`: Used to display directions between two locations on the map.
/// - `streetview`: Used to display a street view of a specific location.
/// - `search`: Used to display search results on the map.
enum MapMode { place, view, directions, streetview, search }

/// Enum representing different modes of transportation for directions.
///
/// The available modes are:
/// - [driving]: Indicates driving directions.
/// - [walking]: Indicates walking directions.
/// - [bicycling]: Indicates bicycling directions.
/// - [transit]: Indicates transit directions.
/// - [flying]: Indicates flying directions.
enum DirectionMode { driving, walking, bicycling, transit, flying }

/// Represents the type of map to be displayed.
///
/// The available map types are:
/// - [MapType.roadmap]: Displays a normal, street-level map.
/// - [MapType.satellite]: Displays a satellite image of the area.
enum MapType { roadmap, satellite }

/// The units of measurement for distance in the Google Maps Embed API.
///
/// The [Units] enum represents the available options for specifying the units of measurement
/// for distance in the Google Maps Embed API. The two options are [metric] and [imperial].
enum Units { metric, imperial }

/// Enum representing different types of routes to avoid.
///
/// The [Avoid] enum is used to specify the types of routes to avoid when generating directions using the Google Maps Embed API.
/// It includes the following options:
/// - [tolls]: Avoid toll roads.
/// - [ferries]: Avoid ferries.
/// - [highways]: Avoid highways.
enum Avoid { tolls, ferries, highways }

/// Represents a set of coordinates consisting of latitude and longitude.
class Coordinates {
  final double latitude;
  final double longitude;

  /// Creates a new instance of [Coordinates] with the given [latitude] and [longitude].
  const Coordinates(this.latitude, this.longitude);
}

/// A type definition for a place ID.
typedef PlaceId = String;

/// Represents a place in the Google Maps Embed API.
///
/// A place can be identified by its place ID, name, address, or coordinates.
class Place {
  final String value;

  const Place._({required this.value});

  /// Creates a Place instance using a place ID.
  factory Place.id(PlaceId placeId) => Place._(value: "place_id:$placeId");

  /// Creates a Place instance using a place name.
  factory Place.name(String placeName) => Place._(value: placeName);

  /// Creates a Place instance using an address.
  factory Place.address(String address) => Place._(value: address);

  /// Creates a Place instance using latitude and longitude coordinates.
  factory Place.coordinates(double latitude, double longitude) =>
      Place._(value: "$latitude,$longitude");
}

/// Represents the parameters for the Google Maps Embed API.
///
/// The [Parameters] class defines the various parameters that can be used
/// when embedding a Google Map. It includes properties such as the map mode,
/// API key, center coordinates, zoom level, map type, language, and region.
///
/// The [Parameters] class is a sealed class, meaning it has a fixed set of
/// subclasses that inherit from it. This allows for better type safety and
/// ensures that only valid combinations of parameters can be used.
///
/// The [Parameters] class provides methods to convert the parameters into a
/// map representation and to generate the query parameters string for the API
/// request. It also overrides the [hashCode] and [operator ==] methods for
/// proper comparison and equality checks.
/// See:
/// [PlaceParameters] Displays a map pin at a particular place or address, such as a landmark, business, geographic feature, or town.
/// [ViewParameters] Displays a map with no markers or directions
/// [DirectionParameters] Displays the path between two or more specified points on the map, as well as the distance and travel time.
/// [StreetViewParameters] Shows interactive panoramic views from designated locations.
/// [SearchParameters] Shows results for a search across the visible map region.
sealed class Parameters {
  static const int kMinZoom = 0;
  static const int kMaxZoom = 21;

  final MapMode mode;
  final String key;
  final Coordinates? center;
  final MapType? mapType;
  final String? language;
  final String? region;
  final int? zoom;

  /// Creates a new instance of [Parameters] with the given values.
  ///
  /// The [mode] parameter specifies the map mode, which can be either
  /// [MapMode.staticMap] or [MapMode.streetView].
  ///
  /// The [key] parameter is the API key that is required to access the
  /// Google Maps Embed API.
  ///
  /// The [center] parameter specifies the coordinates of the center point
  /// of the map. It can be null if not needed.
  ///
  /// The [zoom] parameter specifies the zoom level of the map. It must be
  /// between [kMinZoom] and [kMaxZoom], inclusive. If not provided, the
  /// default zoom level will be used.
  ///
  /// The [mapType] parameter specifies the type of map to display. It can
  /// be null if not needed.
  ///
  /// The [language] parameter specifies the language to use for the map
  /// labels and controls. It can be null if not needed.
  ///
  /// The [region] parameter specifies the region to bias the map's viewport.
  /// It can be null if not needed.
  ///
  /// Throws an [AssertionError] if the [zoom] parameter is provided and
  /// is not within the valid range.
  const Parameters({
    required this.mode,
    required this.key,
    this.center,
    this.zoom,
    this.mapType,
    this.language,
    this.region,
  }) : assert(zoom == null || (zoom >= kMinZoom && zoom <= kMaxZoom),
            "Zoom must be between $kMinZoom and $kMaxZoom");

  /// Converts the parameters into a map representation.
  ///
  /// Returns a [Map] object where the keys are the parameter names and the
  /// values are their corresponding string representations.
  @protected
  Map<String, String> toMap() {
    return {
      "key": key,
      if (center != null) "center": center!.stringValue,
      if (zoom != null) "zoom": "$zoom",
      if (mapType != null) "maptype": mapType!.name,
      if (language != null) "language": language!,
      if (region != null) "region": region!,
    };
  }

  /// Generates the query parameters string for the API request.
  ///
  /// Returns a string containing the query parameters in the format
  /// "key1=value1&key2=value2&...". The values are URL-encoded.
  String getQueryParameters() {
    final map = toMap();
    return map.entries
        .map((e) => "${e.key}=${Uri.encodeQueryComponent(e.value)}")
        .join("&");
  }

  @override
  int get hashCode => toMap().values.fold(0, (p, c) => p ^ c.hashCode);

  @override
  bool operator ==(Object other) {
    return other is Parameters && mapEquals(toMap(), other.toMap());
  }
}

/// A class representing the parameters for a place in the Google Maps Embed API.
///
/// This class extends the [Parameters] class and adds a [Place] object as a required parameter.
/// It also overrides the [toMap] method to include the "q" parameter in the returned map.
///
/// Reference: https://developers.google.com/maps/documentation/embed/embedding-map#place_mode
class PlaceParameters extends Parameters {
  final Place q;

  PlaceParameters({
    required super.key,
    required this.q,
    super.center,
    super.zoom,
    super.mapType,
    super.language,
    super.region,
  }) : super(mode: MapMode.place);

  @override
  Map<String, String> toMap() {
    return {
      ...super.toMap(),
      "q": q.value,
    };
  }
}

/// A class that represents the view parameters for a Google Maps embed.
/// It extends the `Parameters` class and provides additional properties and methods specific to the view mode.
///
/// Reference: https://developers.google.com/maps/documentation/embed/embedding-map#view_mode
class ViewParameters extends Parameters {
  /// Constructs a new `ViewParameters` instance.
  ///
  /// The `key` parameter is required and specifies the API key for the Google Maps embed.
  /// The `center` parameter is required and specifies the coordinates for the center of the map.
  /// The `zoom`, `language`, `mapType`, and `region` parameters are optional and provide additional customization options.
  const ViewParameters({
    required super.key,
    required Coordinates center,
    super.zoom,
    super.language,
    super.mapType,
    super.region,
  }) : super(mode: MapMode.view, center: center);

  @override
  Map<String, String> toMap() {
    return {
      ...super.toMap(),
      "center": center!.stringValue,
    };
  }
}

/// Represents the parameters for a direction request in the Google Maps Embed API.
///
/// The [DirectionParameters] class extends the [Parameters] class and provides additional properties and methods specific to direction requests.
///
/// The direction request requires an origin and a destination, and can optionally include waypoints, direction mode, avoids, and units.
///
/// The maximum number of waypoints allowed in a direction request is defined by the constant [kMaxWaypoints].
///
/// Reference: https://developers.google.com/maps/documentation/embed/embedding-map#directions_mode
class DirectionParameters extends Parameters {
  final Place origin;
  final Place destination;
  final List<Place>? waypoints;
  final DirectionMode? directionMode;
  final List<Avoid>? avoids;
  final Units? units;

  /// The maximum number of waypoints allowed in a direction request.
  static const kMaxWaypoints = 20;

  const DirectionParameters({
    required super.key,
    required this.origin,
    required this.destination,
    this.waypoints,
    this.directionMode,
    this.avoids,
    this.units,
    super.center,
    super.zoom,
    super.mapType,
    super.language,
    super.region,
  })  : assert(waypoints == null || waypoints.length <= kMaxWaypoints,
            "Waypoints must be less than or equal to $kMaxWaypoints"),
        super(mode: MapMode.directions);

  @override
  Map<String, String> toMap() {
    return {
      ...super.toMap(),
      "origin": origin.value,
      "destination": destination.value,
      if (waypoints != null && waypoints!.isNotEmpty)
        "waypoints": waypoints!.map((e) => e.value).join("|"),
      if (directionMode != null) "mode": directionMode!.name,
      if (avoids != null && avoids!.isNotEmpty)
        "avoid": avoids!.map((e) => e.name).join("|"),
      if (units != null) "units": units!.name,
    };
  }
}

/// Represents the parameters for a street view in Google Maps.
///
/// The [StreetViewParameters] class extends the [Parameters] class and provides additional parameters specific to street view.
///
/// The parameters include:
/// - [location]: The coordinates of the location to display in street view.
/// - [pano]: The panorama ID of the location to display in street view.
/// - [heading]: The heading angle of the street view camera. Must be between -180 and 360.
/// - [pitch]: The pitch angle of the street view camera. Must be between -90 and 90.
/// - [fov]: The field of view angle of the street view camera. Must be between 10 and 100.
///
/// The [StreetViewParameters] class also overrides the [toMap] method to convert the parameters into a map of key-value pairs.
///
/// Example usage:
/// ```dart
/// final parameters = StreetViewParameters(
///   location: Coordinates(37.7749, -122.4194),
///   heading: 180,
///   pitch: 0,
///   fov: 90,
/// );
///
/// final parameterMap = parameters.toMap();
/// print(parameterMap);
/// ```
/// Reference: https://developers.google.com/maps/documentation/embed/embedding-map#streetview_mode

class StreetViewParameters extends Parameters {
  static const kMinHeading = -180;
  static const kMaxHeading = 360;
  static const kMinPitch = -90;
  static const kMaxPitch = 90;
  static const kMinFov = 10;
  static const kMaxFov = 100;

  final Coordinates? location;
  final String? pano;
  final int? heading; //-180 -> 360
  final int? pitch; // -90 - 90
  final int? fov; // 10 - 100

  const StreetViewParameters({
    required super.key,
    required this.location,
    this.pano,
    super.center,
    super.zoom,
    super.mapType,
    super.language,
    super.region,
    this.heading,
    this.pitch,
    this.fov,
  })  : assert(location != null || pano != null,
            "Missing location or panoId parameters"),
        assert(
            heading == null ||
                (heading >= kMinHeading && heading <= kMaxHeading),
            "Heading must be between $kMinHeading and $kMaxHeading"),
        assert(pitch == null || (pitch >= kMinPitch && pitch <= kMaxPitch),
            "Pitch must be between $kMinPitch and $kMaxPitch"),
        assert(fov == null || (fov >= kMinFov && fov <= kMaxFov),
            "Fov must be between $kMinFov and $kMaxFov"),
        super(mode: MapMode.streetview);

  @override
  Map<String, String> toMap() {
    return {
      ...super.toMap(),
      if (location != null) "location": location!.stringValue,
      if (pano != null) "pano": pano!,
      if (heading != null) "heading": "$heading",
      if (pitch != null) "pitch": "$pitch",
      if (fov != null) "fov": "$fov",
    };
  }
}

/// A class representing search parameters for the Google Maps Embed Flutter package.
///
/// This class extends the [Parameters] class and adds a [q] parameter for search queries.
/// It also overrides the [toMap] method to include the [q] parameter in the resulting map.
/// Reference: https://developers.google.com/maps/documentation/embed/embedding-map#search_mode
class SearchParameters extends Parameters {
  final Place q;

  /// Creates a new instance of [SearchParameters].
  ///
  /// The [q] parameter is required and represents the search query.
  /// The [key], [center], [zoom], [mapType], [language], and [region] parameters are inherited from the [Parameters] class.
  const SearchParameters({
    required super.key,
    required this.q,
    super.center,
    super.zoom,
    super.mapType,
    super.language,
    super.region,
  }) : super(mode: MapMode.search);

  @override
  Map<String, String> toMap() {
    return {
      ...super.toMap(),
      "q": q.value,
    };
  }
}
