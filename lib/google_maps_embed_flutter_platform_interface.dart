import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'google_maps_embed_flutter_method_channel.dart';

abstract class GoogleMapsEmbedFlutterPlatform extends PlatformInterface {
  /// Constructs a GoogleMapsEmbedFlutterPlatform.
  GoogleMapsEmbedFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static GoogleMapsEmbedFlutterPlatform _instance =
      MethodChannelGoogleMapsEmbedFlutter();

  /// The default instance of [GoogleMapsEmbedFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelGoogleMapsEmbedFlutter].
  static GoogleMapsEmbedFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GoogleMapsEmbedFlutterPlatform] when
  /// they register themselves.
  static set instance(GoogleMapsEmbedFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
}
