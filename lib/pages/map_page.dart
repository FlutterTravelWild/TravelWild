import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // MapController mapcontroller = MapController.customLayer(
  //   initMapWithUserPosition: false,
  //   initPosition: GeoPoint(
  //     latitude: 47.4358055,
  //     longitude: 8.4737324,
  //   ),
  //   customTile: CustomTile(
  //     sourceName: "opentopomap",
  //     tileExtension: ".png",
  //     minZoomLevel: 2,
  //     maxZoomLevel: 19,
  //     urlsServers: [
  //       TileURLs(
  //         url: "https://tile.opentopomap.org/",
  //         subdomains: [],
  //       )
  //     ],
  //     tileSize: 256,
  //   ),
  // );

  // Future<void> getLoc() async {
  //   await mapcontroller.currentLocation();
  // }

  @override
  Widget build(BuildContext context) {
    // Widget map = OSMFlutter(
    //   controller: mapcontroller,
    //   trackMyPosition: false,
    //   initZoom: 12,
    //   minZoomLevel: 8,
    //   maxZoomLevel: 14,
    //   stepZoom: 1.0,
    //   userLocationMarker: UserLocationMaker(
    //     personMarker: MarkerIcon(
    //       icon: Icon(
    //         Icons.location_history_rounded,
    //         color: Colors.red,
    //         size: 48,
    //       ),
    //     ),
    //     directionArrowMarker: MarkerIcon(
    //       icon: Icon(
    //         Icons.double_arrow,
    //         size: 48,
    //       ),
    //     ),
    //   ),
    //   roadConfiguration: RoadConfiguration(
    //     startIcon: MarkerIcon(
    //       icon: Icon(
    //         Icons.person,
    //         size: 64,
    //         color: Colors.brown,
    //       ),
    //     ),
    //     roadColor: Colors.yellowAccent,
    //   ),
    //   markerOption: MarkerOption(
    //       defaultMarker: MarkerIcon(
    //     icon: Icon(
    //       Icons.person_pin_circle,
    //       color: Colors.blue,
    //       size: 56,
    //     ),
    //   )),
    // );
  

    // getLoc();

    return Scaffold(
        appBar: AppBar(
          title: Text("Mapa"),
        ),
        body: Column(
          children: [Text("mapa")],
        ));
  }
}
