import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_embed_flutter/parameters/parameters.dart';

void main() {
  group('ViewParameters', () {
    test('getQueryParameters should return the correct query parameters', () {
      final parameters = ViewParameters(
        key: 'YOUR_API_KEY',
      );
      parameters.center = Coordinates(37.7749, -122.4194);
      parameters.zoom = 12;
      parameters.mapType = MapType.roadmap;
      parameters.language = 'en';
      parameters.region = 'us';

      final queryParameters = parameters.getQueryParameters();

      expect(queryParameters,
          'key=YOUR_API_KEY&center=37.7749%2C-122.4194&zoom=12&maptype=roadmap&language=en&region=us');
    });

    test('toMap should return the correct map representation of the parameters',
        () {
      final parameters = ViewParameters(
        key: 'YOUR_API_KEY',
      );
      parameters.center = Coordinates(40.7128, -74.006);
      parameters.zoom = 15;
      parameters.mapType = MapType.satellite;
      parameters.language = 'en';
      parameters.region = 'us';

      final paramMap = parameters.toMap();

      expect(paramMap, {
        'key': 'YOUR_API_KEY',
        'center': '40.7128,-74.006',
        'zoom': '15',
        'maptype': 'satellite',
        'language': 'en',
        'region': 'us',
      });
    });

    test('hashCode should return the same value for equal instances', () {
      final parameters1 = ViewParameters(
        key: 'YOUR_API_KEY',
      );
      parameters1.center = Coordinates(37.7749, -122.4194);
      parameters1.zoom = 12;
      parameters1.mapType = MapType.roadmap;
      parameters1.language = 'en';
      parameters1.region = 'us';

      final parameters2 = ViewParameters(
        key: 'YOUR_API_KEY',
      );
      parameters2.center = Coordinates(37.7749, -122.4194);
      parameters2.zoom = 12;
      parameters2.mapType = MapType.roadmap;
      parameters2.language = 'en';
      parameters2.region = 'us';

      expect(parameters1.hashCode, parameters2.hashCode);
    });

    test('operator == should return true for equal instances', () {
      final parameters1 = ViewParameters(
        key: 'YOUR_API_KEY',
      );
      parameters1.center = Coordinates(37.7749, -122.4194);
      parameters1.zoom = 12;
      parameters1.mapType = MapType.roadmap;
      parameters1.language = 'en';
      parameters1.region = 'us';

      final parameters2 = ViewParameters(
        key: 'YOUR_API_KEY',
      );
      parameters2.center = Coordinates(37.7749, -122.4194);
      parameters2.zoom = 12;
      parameters2.mapType = MapType.roadmap;
      parameters2.language = 'en';
      parameters2.region = 'us';

      expect(parameters1 == parameters2, true);
    });
  });

  group('PlaceParameters', () {
    test(
        'setQWithPlaceId should set the q parameter with the specified place ID',
        () {
      final parameters = PlaceParameters(key: 'YOUR_API_KEY');
      parameters.setQWithPlaceId('PLACE_ID');

      expect(parameters.q, 'place_id:PLACE_ID');
    });

    test(
        'setQWithCoordinates should set the q parameter with the specified coordinates',
        () {
      final parameters = PlaceParameters(key: 'YOUR_API_KEY');
      parameters.setQWithCoordinates(Coordinates(37.7749, -122.4194));

      expect(parameters.q, '37.7749,-122.4194');
    });

    test('toMap should return the correct map representation of the parameters',
        () {
      final parameters = PlaceParameters(key: 'YOUR_API_KEY');
      parameters.setQWithPlaceId('PLACE_ID');

      final paramMap = parameters.toMap();

      expect(paramMap, {
        'key': 'YOUR_API_KEY',
        'q': 'place_id:PLACE_ID',
      });
    });

    test('toMap should throw an ArgumentError if q parameter is missing', () {
      final parameters = PlaceParameters(key: 'YOUR_API_KEY');

      expect(() => parameters.toMap(), throwsArgumentError);
    });
  });

  group('DirectionParameters', () {
    test(
        'setOriginWithPlaceId should set the origin with the specified place ID',
        () {
      final parameters = DirectionParameters(key: 'YOUR_API_KEY');
      parameters.setOriginWithPlaceId('PLACE_ID');

      expect(parameters.origin, 'place_id:PLACE_ID');
    });

    test(
        'setOriginWithCoordinates should set the origin with the specified coordinates',
        () {
      final parameters = DirectionParameters(key: 'YOUR_API_KEY');
      parameters.setOriginWithCoordinates(Coordinates(37.7749, -122.4194));

      expect(parameters.origin, '37.7749,-122.4194');
    });

    test(
        'setDestinationWithPlaceId should set the destination with the specified place ID',
        () {
      final parameters = DirectionParameters(key: 'YOUR_API_KEY');
      parameters.setDestinationWithPlaceId('PLACE_ID');

      expect(parameters.destination, 'place_id:PLACE_ID');
    });

    test(
        'setDestinationWithCoordinates should set the destination with the specified coordinates',
        () {
      final parameters = DirectionParameters(key: 'YOUR_API_KEY');
      parameters.setDestinationWithCoordinates(Coordinates(37.7749, -122.4194));

      expect(parameters.destination, '37.7749,-122.4194');
    });

    test('addWaypoint should add the waypoint to the direction request', () {
      final parameters = DirectionParameters(key: 'YOUR_API_KEY');
      parameters.addWaypoint('WAYPOINT_1');
      parameters.addWaypoint('WAYPOINT_2');

      expect(parameters.waypoints, ['WAYPOINT_1', 'WAYPOINT_2']);
    });

    test(
        'addWaypointWithPlaceId should add the waypoint with the specified place ID',
        () {
      final parameters = DirectionParameters(key: 'YOUR_API_KEY');
      parameters.addWaypointWithPlaceId('PLACE_ID');

      expect(parameters.waypoints, ['place_id:PLACE_ID']);
    });

    test(
        'addWaypointWithCoordinates should add the waypoint with the specified coordinates',
        () {
      final parameters = DirectionParameters(key: 'YOUR_API_KEY');
      parameters.addWaypointWithCoordinates(Coordinates(37.7749, -122.4194));

      expect(parameters.waypoints, ['37.7749,-122.4194']);
    });

    test('clearWaypoints should clear all waypoints from the direction request',
        () {
      final parameters = DirectionParameters(key: 'YOUR_API_KEY');
      parameters.addWaypoint('WAYPOINT_1');
      parameters.addWaypoint('WAYPOINT_2');
      parameters.clearWaipoints();

      expect(parameters.waypoints, []);
    });

    test(
        'setDirectionMode should set the direction mode for the direction request',
        () {
      final parameters = DirectionParameters(key: 'YOUR_API_KEY');
      parameters.setDirectionMode(DirectionMode.driving);

      expect(parameters.directionMode, DirectionMode.driving);
    });

    test('setAvoids should set the avoids for the direction request', () {
      final parameters = DirectionParameters(key: 'YOUR_API_KEY');
      parameters.setAvoids([Avoid.tolls, Avoid.highways]);

      expect(parameters.avoids, [Avoid.tolls, Avoid.highways]);
    });

    test('setUnits should set the units for the direction request', () {
      final parameters = DirectionParameters(key: 'YOUR_API_KEY');
      parameters.setUnits(Units.metric);

      expect(parameters.units, Units.metric);
    });

    test('toMap should return the correct map representation of the parameters',
        () {
      final parameters = DirectionParameters(key: 'YOUR_API_KEY');
      parameters.setOriginWithPlaceId('ORIGIN_PLACE_ID');
      parameters.setDestinationWithPlaceId('DESTINATION_PLACE_ID');
      parameters.addWaypointWithPlaceId('WAYPOINT_PLACE_ID');
      parameters.setDirectionMode(DirectionMode.driving);
      parameters.setAvoids([Avoid.tolls, Avoid.highways]);
      parameters.setUnits(Units.metric);

      final paramMap = parameters.toMap();

      expect(paramMap, {
        'key': 'YOUR_API_KEY',
        'origin': 'place_id:ORIGIN_PLACE_ID',
        'destination': 'place_id:DESTINATION_PLACE_ID',
        'waypoints': 'place_id:WAYPOINT_PLACE_ID',
        'mode': 'driving',
        'avoid': 'tolls|highways',
        'units': 'metric',
      });
    });

    test('toMap should throw an ArgumentError if origin parameter is missing',
        () {
      final parameters = DirectionParameters(key: 'YOUR_API_KEY');
      parameters.setDestinationWithPlaceId('DESTINATION_PLACE_ID');

      expect(() => parameters.toMap(), throwsArgumentError);
    });

    test(
        'toMap should throw an ArgumentError if destination parameter is missing',
        () {
      final parameters = DirectionParameters(key: 'YOUR_API_KEY');
      parameters.setOriginWithPlaceId('ORIGIN_PLACE_ID');

      expect(() => parameters.toMap(), throwsArgumentError);
    });
  });

  group('StreetViewParameters', () {
    test('setHeading should set the heading value within the valid range', () {
      final parameters = StreetViewParameters(key: 'YOUR_API_KEY');
      parameters.setHeading = 180;

      expect(parameters.heading, 180);
    });

    test(
        'setHeading should throw an ArgumentError if the heading is outside the valid range',
        () {
      final parameters = StreetViewParameters(key: 'YOUR_API_KEY');

      expect(() => parameters.setHeading = 400, throwsArgumentError);
    });

    test('setPitch should set the pitch value within the valid range', () {
      final parameters = StreetViewParameters(key: 'YOUR_API_KEY');
      parameters.setPitch = 45;

      expect(parameters.pitch, 45);
    });

    test(
        'setPitch should throw an ArgumentError if the pitch is outside the valid range',
        () {
      final parameters = StreetViewParameters(key: 'YOUR_API_KEY');

      expect(() => parameters.setPitch = -100, throwsArgumentError);
    });

    test('setFov should set the fov value within the valid range', () {
      final parameters = StreetViewParameters(key: 'YOUR_API_KEY');
      parameters.setFov = 90;

      expect(parameters.fov, 90);
    });

    test(
        'setFov should throw an ArgumentError if the fov is outside the valid range',
        () {
      final parameters = StreetViewParameters(key: 'YOUR_API_KEY');

      expect(() => parameters.setFov = 200, throwsArgumentError);
    });

    test('toMap should return the correct map representation of the parameters',
        () {
      final parameters = StreetViewParameters(key: 'YOUR_API_KEY');
      parameters.location = Coordinates(37.7749, -122.4194);
      parameters.setHeading = 180;
      parameters.setPitch = 45;
      parameters.setFov = 90;

      final paramMap = parameters.toMap();

      expect(paramMap, {
        'key': 'YOUR_API_KEY',
        'location': '37.7749,-122.4194',
        'heading': '180',
        'pitch': '45',
        'fov': '90',
      });
    });

    test(
        'toMap should throw an ArgumentError if both location and pano parameters are missing',
        () {
      final parameters = StreetViewParameters(key: 'YOUR_API_KEY');

      expect(() => parameters.toMap(), throwsArgumentError);
    });

    test('toMap should include the pano parameter if it is set', () {
      final parameters = StreetViewParameters(key: 'YOUR_API_KEY');
      parameters.pano = 'PANO_ID';

      final paramMap = parameters.toMap();

      expect(paramMap, {
        'key': 'YOUR_API_KEY',
        'pano': 'PANO_ID',
      });
    });
  });

  group('SearchParameters', () {
    test('toMap should return the correct map representation of the parameters',
        () {
      final parameters = SearchParameters(key: 'YOUR_API_KEY');
      parameters.q = 'search query';

      final paramMap = parameters.toMap();

      expect(paramMap, {
        'key': 'YOUR_API_KEY',
        'q': 'search query',
      });
    });

    test('toMap should throw an ArgumentError if q parameter is missing', () {
      final parameters = SearchParameters(key: 'YOUR_API_KEY');

      expect(() => parameters.toMap(), throwsArgumentError);
    });
  });
}
