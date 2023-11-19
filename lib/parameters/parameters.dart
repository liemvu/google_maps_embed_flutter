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
  Coordinates(this.latitude, this.longitude);
}

/// Represents the parameters for the Google Maps Embed API.
///
/// The [Parameters] class contains properties and methods for configuring the
/// Google Maps Embed API. It provides options such as the map mode, API key,
/// center coordinates, zoom level, map type, language, and region.
///
/// The [Parameters] class is a sealed class, meaning it has a fixed set of
/// subclasses that inherit from it. This allows for better type safety and
/// ensures that only valid combinations of parameters can be used.
///
/// To create an instance of [Parameters], you need to provide the [mode] and
/// [key] parameters. The [mode] specifies the map mode, which can be either
/// [MapMode.staticMap] or [MapMode.streetView]. The [key] is the API key
/// required to access the Google Maps Embed API.
///
/// The [center] property represents the coordinates of the center point of the
/// map. It is an optional parameter and can be set to `null` if not needed.
///
/// The [zoom] property represents the zoom level of the map. It is an optional
/// parameter and can be set to `null` if not needed. The valid range for the
/// zoom level is between 0 and 21, inclusive. If an invalid zoom level is
/// provided, an [ArgumentError] will be thrown.
///
/// The [mapType] property represents the type of map to be displayed. It is an
/// optional parameter and can be set to `null` if not needed. The available
/// map types are defined by the [MapType] enum.
///
/// The [language] property represents the language to be used for the map
/// labels and controls. It is an optional parameter and can be set to `null` if
/// not needed.
///
/// The [region] property represents the region to be used for the map. It is an
/// optional parameter and can be set to `null` if not needed.
///
/// The [getQueryParameters] method returns a string representation of the
/// parameters in the format required for the API request. It encodes the
/// parameter values using URI encoding.
///
/// The [hashCode] and [operator ==] methods are overridden to provide proper
/// equality comparison for instances of [Parameters]. Two instances of
/// [Parameters] are considered equal if their parameter values are equal.
/// See:
/// [PlaceParameters] Displays a map pin at a particular place or address, such as a landmark, business, geographic feature, or town.
/// [ViewParameters] Displays a map with no markers or directions
/// [DirectionParameters] Displays the path between two or more specified points on the map, as well as the distance and travel time.
/// [StreetViewParameters] Shows interactive panoramic views from designated locations.
/// [SearchParameters] Shows results for a search across the visible map region.
sealed class Parameters {
  final MapMode mode;
  final String key;
  Coordinates? center;
  MapType? mapType;
  String? language;
  String? region;

  int? _zoom;
  int? get zoom => _zoom;
  static const int kMinZoom = 0;
  static const int kMaxZoom = 21;
  set zoom(int? zoom) {
    if (zoom != null && (zoom < kMinZoom || zoom > kMaxZoom)) {
      throw ArgumentError("Zoom must be between $kMinZoom and $kMaxZoom");
    }
    _zoom = zoom;
  }

  Parameters({required this.mode, required this.key});

  @protected
  Map<String, String> toMap() {
    return {
      "key": key,
      if (center != null) "center": center!.stringValue,
      if (zoom != null) "zoom": "$_zoom",
      if (mapType != null) "maptype": mapType!.name,
      if (language != null) "language": language!,
      if (region != null) "region": region!,
    };
  }

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

/// A class representing the parameters for a place search in the Google Maps Embed API.
///
/// This class extends the [Parameters] class and provides additional functionality
/// for setting the query parameter ([q]) based on either a place ID or coordinates.
///
/// The [q] parameter is required and must be set before calling the [toMap] method.
///
/// Example usage:
/// ```dart
/// PlaceParameters parameters = PlaceParameters(key: "YOUR_API_KEY");
/// parameters.setQWithPlaceId("PLACE_ID");
/// Map<String, String> paramMap = parameters.toMap();
/// ```
class PlaceParameters extends Parameters {
  String? q;

  /// Sets the [q] parameter with the specified place ID.
  void setQWithPlaceId(String placeId) => q = "place_id:$placeId";

  /// Sets the [q] parameter with the specified coordinates.
  void setQWithCoordinates(Coordinates coordinates) =>
      q = coordinates.stringValue;

  /// Creates a new instance of [PlaceParameters] with the given API key.
  PlaceParameters({required String key}) : super(mode: MapMode.place, key: key);

  @override
  Map<String, String> toMap() {
    if (q == null) {
      throw ArgumentError("Missing q parameters");
    }

    return {
      ...super.toMap(),
      "q": q!,
    };
  }
}

/// A class that represents the view parameters for the Google Maps Embed API.
///
/// This class extends the [Parameters] class and provides additional functionality
/// for specifying the center of the map.
class ViewParameters extends Parameters {
  ViewParameters({required String key}) : super(mode: MapMode.view, key: key);

  @override
  Map<String, String> toMap() {
    if (center == null) {
      throw ArgumentError("Missing center parameters");
    }

    return {
      ...super.toMap(),
      "center": center!.stringValue,
    };
  }
}

/// A class that represents the parameters for a direction request in Google Maps.
///
/// This class extends the [Parameters] class and provides methods to set the origin,
/// destination, waypoints, direction mode, avoids, and units for the direction request.
class DirectionParameters extends Parameters {
  String? origin;
  String? destination;
  List<String>? waypoints;
  DirectionMode? directionMode;
  List<Avoid>? avoids;
  Units? units;

  /// The maximum number of waypoints allowed in a direction request.
  static const kMaxWaypoints = 20;

  /// Sets the origin using a place ID.
  ///
  /// The [placeId] parameter is the unique identifier of the place.
  void setOriginWithPlaceId(String placeId) => origin = "place_id:$placeId";

  /// Sets the origin using coordinates.
  ///
  /// The [coordinates] parameter is an instance of the [Coordinates] class that represents the latitude and longitude values.
  void setOriginWithCoordinates(Coordinates coordinates) =>
      origin = coordinates.stringValue;

  /// Sets the destination using a place ID.
  ///
  /// The [placeId] parameter is the unique identifier of the place.
  void setDestinationWithPlaceId(String placeId) =>
      destination = "place_id:$placeId";

  /// Sets the destination using coordinates.
  ///
  /// The [coordinates] parameter is an instance of the [Coordinates] class that represents the latitude and longitude values.
  void setDestinationWithCoordinates(Coordinates coordinates) =>
      destination = coordinates.stringValue;

  /// Adds a waypoint to the direction request.
  ///
  /// The [waypoint] parameter is the location to be added as a waypoint.
  /// Throws an [ArgumentError] if the maximum number of waypoints is exceeded.
  void addWaypoint(String waypoint) {
    waypoints ??= [];
    if (waypoints!.length > kMaxWaypoints) {
      throw ArgumentError("Waypoints must be less than $kMaxWaypoints");
    }
    waypoints!.add(waypoint);
  }

  /// Adds a waypoint using a place ID.
  ///
  /// The [placeId] parameter is the unique identifier of the place.
  void addWaypointWithPlaceId(String placeId) =>
      addWaypoint("place_id:$placeId");

  /// Adds a waypoint using coordinates.
  ///
  /// The [coordinates] parameter is an instance of the [Coordinates] class that represents the latitude and longitude values.
  void addWaypointWithCoordinates(Coordinates coordinates) =>
      addWaypoint(coordinates.stringValue);

  /// Clears all waypoints from the direction request.
  void clearWaipoints() => waypoints?.clear();

  /// Sets the direction mode for the direction request.
  ///
  /// The [mode] parameter is an instance of the [DirectionMode] enum that represents the mode of transportation.
  void setDirectionMode(DirectionMode mode) => directionMode = mode;

  /// Sets the avoids for the direction request.
  ///
  /// The [avoids] parameter is a list of [Avoid] enums that represent the features to avoid during the route calculation.
  void setAvoids(List<Avoid> avoids) => this.avoids = avoids;

  /// Sets the units for the direction request.
  ///
  /// The [units] parameter is an instance of the [Units] enum that represents the unit system to use for the directions.
  void setUnits(Units units) => this.units = units;

  /// Creates a new instance of [DirectionParameters].
  ///
  /// The [key] parameter is the API key for the Google Maps service.
  DirectionParameters({required String key})
      : super(mode: MapMode.directions, key: key);

  @override
  Map<String, String> toMap() {
    if (origin == null) {
      throw ArgumentError("Missing origin parameters");
    }

    if (destination == null) {
      throw ArgumentError("Missing destination parameters");
    }

    return {
      ...super.toMap(),
      "origin": origin!,
      "destination": destination!,
      if (waypoints != null && waypoints!.isNotEmpty)
        "waypoints": waypoints!.join("|"),
      if (directionMode != null) "mode": directionMode!.name,
      if (avoids != null && avoids!.isNotEmpty)
        "avoid": avoids!.map((e) => e.name).join("|"),
      if (units != null) "units": units!.name,
    };
  }
}

/// A class that represents the parameters for a street view in Google Maps.
///
/// This class extends the [Parameters] class and provides additional
/// properties and methods specific to street view parameters.
class StreetViewParameters extends Parameters {
  /// The coordinates of the location to display on the map.
  Coordinates? location;

  /// The panorama ID to display in the Street View panorama.
  String? pano;

  int? _heading; //-180 -> 360
  int? get heading => _heading;

  /// The minimum allowed heading value.
  static const kMinHeading = -180;

  /// The maximum allowed heading value.
  static const kMaxHeading = 360;

  /// Sets the heading value.
  /// Throws an [ArgumentError] if the provided heading is outside the valid range.
  set setHeading(int? heading) {
    if (heading != null && (heading < kMinHeading || heading > kMaxHeading)) {
      throw ArgumentError(
          "Heading must be between $kMinHeading and $kMaxHeading");
    }
    _heading = heading;
  }

  int? _pitch; // -90 - 90
  int? get pitch => _pitch;

  /// The minimum allowed pitch value.
  static const kMinPitch = -90;

  /// The maximum allowed pitch value.
  static const kMaxPitch = 90;

  /// Sets the pitch value.
  /// Throws an [ArgumentError] if the provided pitch is outside the valid range.
  set setPitch(int? pitch) {
    if (pitch != null && (pitch < kMinPitch || pitch > kMaxPitch)) {
      throw ArgumentError("Pitch must be between $kMinPitch and $kMaxPitch");
    }
    _pitch = pitch;
  }

  int? _fov; // 10 - 100
  int? get fov => _fov;

  /// The minimum allowed fov value.
  static const kMinFov = 10;

  /// The maximum allowed fov value.
  static const kMaxFov = 100;

  /// Sets the fov value.
  /// Throws an [ArgumentError] if the provided fov is outside the valid range.
  set setFov(int? fov) {
    if (fov != null && (fov < kMinFov || fov > kMaxFov)) {
      throw ArgumentError("Fov must be between $kMinFov and $kMaxFov");
    }
    _fov = fov;
  }

  /// Creates a new instance of [StreetViewParameters] with the given API key.
  ///
  /// The [key] parameter is required and must be a valid Google Maps API key.
  StreetViewParameters({required String key})
      : super(mode: MapMode.streetview, key: key);

  @override
  Map<String, String> toMap() {
    if (location == null && pano == null) {
      throw ArgumentError("Missing location or pano parameters");
    }

    return {
      ...super.toMap(),
      if (location != null) "location": location!.stringValue,
      if (pano != null) "pano": pano!,
      if (_heading != null) "heading": "$_heading",
      if (_pitch != null) "pitch": "$_pitch",
      if (_fov != null) "fov": "$_fov",
    };
  }
}

/// Represents the search parameters for the Google Maps Embed API.
/// Extends the base [Parameters] class.
class SearchParameters extends Parameters {
  String? q;

  /// Constructs a new instance of [SearchParameters] with the provided API key.
  SearchParameters({required String key})
      : super(mode: MapMode.search, key: key);

  @override

  /// Converts the search parameters to a map of key-value pairs.
  /// Throws an [ArgumentError] if the required parameter 'q' is missing.
  Map<String, String> toMap() {
    if (q == null) {
      throw ArgumentError("Missing q parameters");
    }
    return {
      ...super.toMap(),
      "q": q!,
    };
  }
}
