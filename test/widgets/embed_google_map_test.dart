import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmbedGoogleMap', () {
    // testWidgets('renders WebViewWidget', (WidgetTester tester) async {
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: EmbedGoogleMap(
    //         parameters: ViewParameters(key: 'YOUR_API_KEY'),
    //       ),
    //     ),
    //   );

    //   expect(find.byType(WebViewWidget), findsOneWidget);
    // });

    // testWidgets('loads map with correct parameters',
    //     (WidgetTester tester) async {
    //   final parameters = ViewParameters(
    //     key: 'YOUR_API_KEY',
    //   )
    //     ..center = Coordinates(37.7749, -122.4194)
    //     ..zoom = 12
    //     ..mapType = MapType.roadmap
    //     ..language = 'en'
    //     ..region = 'us';

    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: EmbedGoogleMap(
    //         parameters: parameters,
    //       ),
    //     ),
    //   );

    //   final webViewFinder = find.byType(WebViewWidget);
    //   expect(webViewFinder, findsOneWidget);

    //   final mapWidgetFinder = find.byType(EmbedGoogleMap);
    //   final mapWidgetState =
    //       tester.state(mapWidgetFinder) as EmbedGoogleMapState;

    //   final controller = mapWidgetState.controller;

    //   final html = await controller.currentUrl();
    //   expect(html, contains('key=YOUR_API_KEY'));
    //   expect(html, contains('center=37.7749%2C-122.4194'));
    //   expect(html, contains('zoom=12'));
    //   expect(html, contains('maptype=roadmap'));
    //   expect(html, contains('language=en'));
    //   expect(html, contains('region=us'));
    // });

    // testWidgets('calls onNavigationRequest callback',
    //     (WidgetTester tester) async {
    //   final parameters = ViewParameters(key: 'YOUR_API_KEY');
    //   NavigationRequest? receivedRequest;

    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: EmbedGoogleMap(
    //         parameters: parameters,
    //         onNavigationRequest: (request) {
    //           receivedRequest = request;
    //           return NavigationDecision.navigate;
    //         },
    //       ),
    //     ),
    //   );

    //   final webViewFinder = find.byType(WebViewWidget);
    //   expect(webViewFinder, findsOneWidget);

    //   final mapWidgetFinder = find.byType(EmbedGoogleMap);
    //   final mapWidgetState =
    //       tester.state(mapWidgetFinder) as EmbedGoogleMapState;

    //   final controller = mapWidgetState.controller;

    //   const navigationRequest =
    //       NavigationRequest(url: "https://www.example.com", isMainFrame: true);

    //   await controller
    //       .runJavaScript('window.location.href = "${navigationRequest.url}";');

    //   await tester.pumpAndSettle();

    //   expect(receivedRequest, equals(navigationRequest));
    // });

    //   testWidgets('launches external application for non-Google Maps URLs',
    //       (WidgetTester tester) async {
    //     final parameters = ViewParameters(key: 'YOUR_API_KEY');

    //     await tester.pumpWidget(
    //       MaterialApp(
    //         home: EmbedGoogleMap(
    //           parameters: parameters,
    //         ),
    //       ),
    //     );

    //     final webViewFinder = find.byType(WebViewWidget);
    //     expect(webViewFinder, findsOneWidget);

    //     final mapWidgetFinder = find.byType(EmbedGoogleMap);
    //     final mapWidgetState =
    //         tester.state(mapWidgetFinder) as EmbedGoogleMapState;

    //     final controller = mapWidgetState.controller;

    //     const navigationRequest =
    //         NavigationRequest(url: "https://www.example.com", isMainFrame: true);

    //     await controller
    //         .runJavaScript('window.location.href = "${navigationRequest.url}";');

    //     await tester.pumpAndSettle();

    //     final externalApplicationRequest =
    //         await tester.waitForExtrernalApplicationRequest();
    //     expect(externalApplicationRequest.url, equals(navigationRequest.url));
    //   });
  });
}
