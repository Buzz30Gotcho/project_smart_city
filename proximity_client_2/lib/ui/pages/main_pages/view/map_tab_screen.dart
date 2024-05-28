import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proximity/config/themes/google_map_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTabScreen extends StatefulWidget {
  const MapTabScreen({Key? key}) : super(key: key);

  @override
  State<MapTabScreen> createState() => _MapTabScreenState();
}

class _MapTabScreenState extends State<MapTabScreen> {
  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> controller = Completer();
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        controller.setMapStyle(
            (Theme.of(context).brightness == Brightness.dark)
                ? GoogleMapsThemes.darkTheme
                : GoogleMapsThemes.lightTheme);
        //_controller.complete(controller);
      },
      myLocationButtonEnabled: false,
      compassEnabled: true,
      trafficEnabled: false,
      zoomControlsEnabled: true,
      tiltGesturesEnabled: false,
      buildingsEnabled: false,
      mapToolbarEnabled: false,
      indoorViewEnabled: false,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
      initialCameraPosition: const CameraPosition(
        target: LatLng(31, 0.6),
        zoom: 14,
      ),
      // markers: Set<Marker>.of(markers.values),
    );
  }
}

