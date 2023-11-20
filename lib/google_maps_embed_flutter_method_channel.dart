import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'google_maps_embed_flutter_platform_interface.dart';

/// An implementation of [GoogleMapsEmbedFlutterPlatform] that uses method channels.
class MethodChannelGoogleMapsEmbedFlutter
    extends GoogleMapsEmbedFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('google_maps_embed_flutter');
}
