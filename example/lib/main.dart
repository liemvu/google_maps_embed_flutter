import 'package:flutter/material.dart';
import 'package:google_maps_embed_flutter/google_maps_embed_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  /// Fill in your API key here
  static const kEmbedMapApiKey = "API_KEY";
  int selectedIndex = 0;
  static const kSegments = [
    "Place",
    "View",
    "Directions",
    "Street view",
    "Search"
  ];
  late final parameters = [
    PlaceParameters(
        key: kEmbedMapApiKey,
        q: Place.address(
            "1600 Amphitheatre Parkway, Mountain View, CA 94043, United States")),
    const ViewParameters(
        key: kEmbedMapApiKey, center: Coordinates(37.4220041, -122.0862462)),
    DirectionParameters(
        key: kEmbedMapApiKey,
        origin: Place.id("ChIJ2eUgeAK6j4ARbn5u_wAGqWA"),
        destination: Place.id("ChIJE9on3F3HwoAR9AhGJW_fL-I")),
    const StreetViewParameters(
        key: kEmbedMapApiKey, location: Coordinates(46.414382, 10.013988)),
    SearchParameters(
        key: kEmbedMapApiKey, q: Place.name("record stores in Seattle"))
  ];
  late final tabController =
      TabController(length: kSegments.length, vsync: this);

  @override
  void initState() {
    super.initState();
  }

  void onSelectionChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.zero,
            child: TabBar(
              isScrollable: true,
              controller: tabController,
              tabs: kSegments.map((e) => Tab(text: e)).toList(),
              onTap: onSelectionChanged,
            ),
          ),
        ),
        body: EmbedGoogleMap(
          parameters: parameters[selectedIndex],
        ),
      ),
    );
  }
}
