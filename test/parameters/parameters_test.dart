import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_embed_flutter/parameters/parameters.dart';

void main() {
  group('PlaceParameters', () {
    test('toMap should return the correct map', () {
      // Arrange
      final q = Place.name('New York');
      final parameters = PlaceParameters(key: 'API_KEY', q: q);

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'q': 'New York',
      });
    });
  });

  group('ViewParameters', () {
    test('toMap should return the correct map', () {
      // Arrange
      const center = Coordinates(37.7749, -122.4194);
      const parameters = ViewParameters(key: 'API_KEY', center: center);

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'center': '37.7749,-122.4194',
      });
    });
  });

  group('DirectionParameters', () {
    test('toMap should return the correct map', () {
      // Arrange
      final origin = Place.name('New York');
      final destination = Place.name('Los Angeles');
      final waypoints = [
        Place.name('Chicago'),
        Place.name('Denver'),
      ];
      const directionMode = DirectionMode.driving;
      final avoids = [Avoid.tolls, Avoid.highways];
      const units = Units.metric;
      final parameters = DirectionParameters(
        key: 'API_KEY',
        origin: origin,
        destination: destination,
        waypoints: waypoints,
        directionMode: directionMode,
        avoids: avoids,
        units: units,
      );

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'origin': 'New York',
        'destination': 'Los Angeles',
        'waypoints': 'Chicago|Denver',
        'mode': 'driving',
        'avoid': 'tolls|highways',
        'units': 'metric',
      });
    });

    test('toMap should return the correct map without optional parameters', () {
      // Arrange
      final origin = Place.name('New York');
      final destination = Place.name('Los Angeles');
      final parameters = DirectionParameters(
        key: 'API_KEY',
        origin: origin,
        destination: destination,
      );

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'origin': 'New York',
        'destination': 'Los Angeles',
      });
    });

    test('toMap should return the correct map with empty waypoints', () {
      // Arrange
      final origin = Place.name('New York');
      final destination = Place.name('Los Angeles');
      final waypoints = <Place>[];
      final parameters = DirectionParameters(
        key: 'API_KEY',
        origin: origin,
        destination: destination,
        waypoints: waypoints,
      );

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'origin': 'New York',
        'destination': 'Los Angeles',
      });
    });

    test('toMap should return the correct map with null waypoints', () {
      // Arrange
      final origin = Place.name('New York');
      final destination = Place.name('Los Angeles');
      final parameters = DirectionParameters(
        key: 'API_KEY',
        origin: origin,
        destination: destination,
        waypoints: null,
      );

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'origin': 'New York',
        'destination': 'Los Angeles',
      });
    });
  });
  group('StreetViewParameters', () {
    test('toMap should return the correct map', () {
      // Arrange
      const location = Coordinates(37.7749, -122.4194);
      const pano = 'panoId';
      const heading = 180;
      const pitch = 45;
      const fov = 90;
      const parameters = StreetViewParameters(
        key: 'API_KEY',
        location: location,
        pano: pano,
        heading: heading,
        pitch: pitch,
        fov: fov,
      );

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'location': '37.7749,-122.4194',
        'pano': 'panoId',
        'heading': '180',
        'pitch': '45',
        'fov': '90',
      });
    });

    test('toMap should return the correct map without optional parameters', () {
      // Arrange
      const location = Coordinates(37.7749, -122.4194);
      const parameters = StreetViewParameters(
        key: 'API_KEY',
        location: location,
      );

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'location': '37.7749,-122.4194',
      });
    });

    test('toMap should return the correct map with null location', () {
      // Arrange
      const pano = 'panoId';
      const heading = 180;
      const pitch = 45;
      const fov = 90;
      const parameters = StreetViewParameters(
        key: 'API_KEY',
        location: null,
        pano: pano,
        heading: heading,
        pitch: pitch,
        fov: fov,
      );

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'pano': 'panoId',
        'heading': '180',
        'pitch': '45',
        'fov': '90',
      });
    });

    test('toMap should return the correct map with null pano', () {
      // Arrange
      const location = Coordinates(37.7749, -122.4194);
      const heading = 180;
      const pitch = 45;
      const fov = 90;
      const parameters = StreetViewParameters(
        key: 'API_KEY',
        location: location,
        heading: heading,
        pitch: pitch,
        fov: fov,
      );

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'location': '37.7749,-122.4194',
        'heading': '180',
        'pitch': '45',
        'fov': '90',
      });
    });

    test('toMap should return the correct map with null heading', () {
      // Arrange
      const location = Coordinates(37.7749, -122.4194);
      const pano = 'panoId';
      const pitch = 45;
      const fov = 90;
      const parameters = StreetViewParameters(
        key: 'API_KEY',
        location: location,
        pano: pano,
        pitch: pitch,
        fov: fov,
      );

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'location': '37.7749,-122.4194',
        'pano': 'panoId',
        'pitch': '45',
        'fov': '90',
      });
    });

    test('toMap should return the correct map with null pitch', () {
      // Arrange
      const location = Coordinates(37.7749, -122.4194);
      const pano = 'panoId';
      const heading = 180;
      const fov = 90;
      const parameters = StreetViewParameters(
        key: 'API_KEY',
        location: location,
        pano: pano,
        heading: heading,
        fov: fov,
      );

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'location': '37.7749,-122.4194',
        'pano': 'panoId',
        'heading': '180',
        'fov': '90',
      });
    });

    test('toMap should return the correct map with null fov', () {
      // Arrange
      const location = Coordinates(37.7749, -122.4194);
      const pano = 'panoId';
      const heading = 180;
      const pitch = 45;
      const parameters = StreetViewParameters(
        key: 'API_KEY',
        location: location,
        pano: pano,
        heading: heading,
        pitch: pitch,
      );

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'location': '37.7749,-122.4194',
        'pano': 'panoId',
        'heading': '180',
        'pitch': '45',
      });
    });
  });

  group("SearchParameters", () {
    test('toMap should return the correct map', () {
      // Arrange
      final q = Place.name('New York');
      final parameters = SearchParameters(
        key: 'API_KEY',
        q: q,
      );

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'q': 'New York',
      });
    });
  });

  group('Parameters', () {
    test('toMap should return the correct map', () {
      const key = 'API_KEY';
      const center = Coordinates(37.7749, -122.4194);
      const zoom = 10;
      const mapType = MapType.roadmap;
      const language = 'en';
      const region = 'us';
      const parameters = ViewParameters(
        key: key,
        center: center,
        zoom: zoom,
        mapType: mapType,
        language: language,
        region: region,
      );

      // Act
      final map = parameters.toMap();

      // Assert
      expect(map, {
        'key': 'API_KEY',
        'center': '37.7749,-122.4194',
        'zoom': '10',
        'maptype': 'roadmap',
        'language': 'en',
        'region': 'us',
      });
    });

    test('getQueryParameters should return the correct query parameters string',
        () {
      // Arrange
      const key = 'API_KEY';
      const center = Coordinates(40.7128, -74.006);
      const zoom = 15;
      const mapType = MapType.satellite;
      const language = 'fr';
      const region = 'fr';
      const parameters = ViewParameters(
        key: key,
        center: center,
        zoom: zoom,
        mapType: mapType,
        language: language,
        region: region,
      );

      // Act
      final queryParameters = parameters.getQueryParameters();

      // Assert
      expect(queryParameters,
          'key=API_KEY&center=40.7128%2C-74.006&zoom=15&maptype=satellite&language=fr&region=fr');
    });

    test(
        'getQueryParameters should return the correct query parameters string without optional parameters',
        () {
      // Arrange
      const key = 'API_KEY';
      const center = Coordinates(34.0522, -118.2437);
      const parameters = ViewParameters(
        key: key,
        center: center,
      );

      // Act
      final queryParameters = parameters.getQueryParameters();

      // Assert
      expect(queryParameters, 'key=API_KEY&center=34.0522%2C-118.2437');
    });

    test(
        'getQueryParameters should return the correct query parameters string with null zoom',
        () {
      // Arrange
      const key = 'API_KEY';
      const center = Coordinates(51.5074, -0.1278);
      const mapType = MapType.roadmap;
      const language = 'en';
      const region = 'gb';
      const parameters = ViewParameters(
        key: key,
        center: center,
        zoom: null,
        mapType: mapType,
        language: language,
        region: region,
      );

      // Act
      final queryParameters = parameters.getQueryParameters();

      // Assert
      expect(queryParameters,
          'key=API_KEY&center=51.5074%2C-0.1278&maptype=roadmap&language=en&region=gb');
    });

    test(
        'getQueryParameters should return the correct query parameters string with null mapType',
        () {
      // Arrange
      const key = 'API_KEY';
      const center = Coordinates(52.52, 13.405);
      const zoom = 12;
      const language = 'de';
      const region = 'de';
      const parameters = ViewParameters(
        key: key,
        center: center,
        zoom: zoom,
        mapType: null,
        language: language,
        region: region,
      );

      // Act
      final queryParameters = parameters.getQueryParameters();

      // Assert
      expect(queryParameters,
          'key=API_KEY&center=52.52%2C13.405&zoom=12&language=de&region=de');
    });

    test(
        'getQueryParameters should return the correct query parameters string with null language',
        () {
      // Arrange
      const key = 'API_KEY';
      const center = Coordinates(48.8566, 2.3522);
      const zoom = 14;
      const mapType = MapType.roadmap;
      const region = 'fr';
      const parameters = ViewParameters(
        key: key,
        center: center,
        zoom: zoom,
        mapType: mapType,
        language: null,
        region: region,
      );

      // Act
      final queryParameters = parameters.getQueryParameters();

      // Assert
      expect(queryParameters,
          'key=API_KEY&center=48.8566%2C2.3522&zoom=14&maptype=roadmap&region=fr');
    });

    test(
        'getQueryParameters should return the correct query parameters string with null region',
        () {
      // Arrange
      const key = 'API_KEY';
      const center = Coordinates(55.7558, 37.6176);
      const zoom = 16;
      const mapType = MapType.roadmap;
      const language = 'ru';
      const parameters = ViewParameters(
        key: key,
        center: center,
        zoom: zoom,
        mapType: mapType,
        language: language,
        region: null,
      );

      // Act
      final queryParameters = parameters.getQueryParameters();

      // Assert
      expect(queryParameters,
          'key=API_KEY&center=55.7558%2C37.6176&zoom=16&maptype=roadmap&language=ru');
    });

    test(
        'getQueryParameters should return the correct query parameters string with null zoom and mapType',
        () {
      // Arrange
      const key = 'API_KEY';
      const center = Coordinates(35.6895, 139.6917);
      const language = 'ja';
      const region = 'jp';
      const parameters = ViewParameters(
        key: key,
        center: center,
        zoom: null,
        mapType: null,
        language: language,
        region: region,
      );

      // Act
      final queryParameters = parameters.getQueryParameters();

      // Assert
      expect(queryParameters,
          'key=API_KEY&center=35.6895%2C139.6917&language=ja&region=jp');
    });
  });
}
