import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_embed_flutter/parameters/parameters.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// A typedef representing a callback function for reporting loading progress.
///
/// The [OnLoadingProgress] function takes an integer parameter [progress]
/// which represents the loading progress. The [progress] value should be
/// between 0 and 100, where 0 indicates no progress and 100 indicates
/// the loading is complete.
typedef OnLoadingProgress = void Function(int progress);

/// A typedef representing a function that handles errors in loading web resources.
///
/// The [OnError] function takes a [WebResourceError] object as a parameter and returns no value.
typedef OnError = void Function(WebResourceError error);

/// A typedef representing a callback function that handles navigation requests.
///
/// The [OnNavigateRequest] function takes a [NavigationDecision] as a parameter and returns a [Future] or [FutureOr] of [NavigationDecision].
/// It is used to determine whether to allow or cancel a navigation request.
typedef OnNavigateRequest = FutureOr<NavigationDecision> Function(
    NavigationRequest request);

/// A widget that embeds a Google Map.
///
/// This widget allows you to embed a Google Map using the provided [parameters].
/// You can customize the appearance of the map by specifying the [backgroundColor].
/// The [loadingProgress] callback allows you to track the loading progress of the map.
/// The [onError] callback is triggered when an error occurs while loading the map.
/// The [onNavigationRequest] callback is called when a navigation request is made within the map.
class EmbedGoogleMap extends StatefulWidget {
  final Parameters parameters;
  final Color? backgroundColor;
  final OnLoadingProgress? loadingProgress;
  final OnError? onError;
  final OnNavigateRequest? onNavigationRequest;

  /// Creates a new [EmbedGoogleMap] instance.
  ///
  /// The [parameters] parameter is required and specifies the parameters for the Google Map.
  /// The [backgroundColor] parameter allows you to specify the background color of the map.
  /// The [loadingProgress] parameter is a callback that tracks the loading progress of the map.
  /// The [onError] parameter is a callback that is triggered when an error occurs while loading the map.
  /// The [onNavigationRequest] parameter is a callback that is called when a navigation request is made within the map.
  const EmbedGoogleMap({
    super.key,
    required this.parameters,
    this.backgroundColor,
    this.loadingProgress,
    this.onError,
    this.onNavigationRequest,
  });

  @override
  State<EmbedGoogleMap> createState() => EmbedGoogleMapState();
}

class EmbedGoogleMapState extends State<EmbedGoogleMap> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    if (widget.backgroundColor != null) {
      controller.setBackgroundColor(widget.backgroundColor!);
    }

    controller.setNavigationDelegate(NavigationDelegate(
      onProgress: widget.loadingProgress,
      onWebResourceError: widget.onError,
      onNavigationRequest: onNavigationRequest,
    ));

    loadMap();
  }

  @override
  void didUpdateWidget(covariant EmbedGoogleMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.parameters != widget.parameters) {
      loadMap();
    }
  }

  Future<NavigationDecision> onNavigationRequest(
      NavigationRequest request) async {
    if (widget.onNavigationRequest != null) {
      return widget.onNavigationRequest!(request);
    }

    if (request.url == "about:blank" ||
        request.url.startsWith("https://www.google.com/maps/embed/v1/")) {
      return NavigationDecision.navigate;
    }

    await launchUrlString(request.url, mode: LaunchMode.externalApplication);
    return NavigationDecision.prevent;
  }

  void loadMap() async {
    final parameters = widget.parameters;
    final html = _kHtml
        .replaceAll("[PARAMETERS]", parameters.getQueryParameters())
        .replaceAll("[MODE]", parameters.mode.name);
    await controller.loadHtmlString(html);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: controller,
    );
  }
}

const _kHtml = """
<!DOCTYPE html>
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>Google Maps Embed</title>
    <style>
        html, body {margin: 0; padding:0; height: 100%; overflow: hidden}
        #map { height: 100vh; width: 100%; }
    </style>
</head>

<body>  
    <div id="map"></div>

    <script>
    const queryString = "[PARAMETERS]";
    const mode = "[MODE]";

    let mapUrl = 'https://www.google.com/maps/embed/v1/';
    mapUrl += mode;
    mapUrl += '?';
    mapUrl += queryString;

    // Create the iframe element with the map URL
    const mapElement = document.createElement('iframe');
    mapElement.setAttribute('src', mapUrl);
    mapElement.setAttribute('width', '100%');
    mapElement.setAttribute('height', '100%'); // Full height
    mapElement.setAttribute('frameborder', '0');
    mapElement.setAttribute('style', 'border:0');
    document.getElementById('map').appendChild(mapElement);
    </script>
</body>

</html>
""";
