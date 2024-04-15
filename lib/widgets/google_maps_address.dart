import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proximity/config/themes/google_map_theme.dart';

class GoogleMapsAddress extends StatefulWidget {
  const GoogleMapsAddress({Key? key, required this.latLng, this.borderRadius})
      : super(key: key);

  final LatLng? latLng;
  final BorderRadius? borderRadius;

  @override
  State<GoogleMapsAddress> createState() => _GoogleMapsAddressState();
}

class _GoogleMapsAddressState extends State<GoogleMapsAddress> {
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? _mapPinIcon;

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  /// This method is used to create the google map
  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(
        (Theme.of(context).brightness == Brightness.dark)
            ? GoogleMapsThemes.darkTheme
            : GoogleMapsThemes.lightTheme);
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    getBytesFromAsset('assets/img/map-pin.png', 64).then((onValue) {
      setState((){
        _mapPinIcon = BitmapDescriptor.fromBytes(onValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller = Completer();
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
    if ((widget.latLng != null) && (_mapPinIcon != null)) {
      const MarkerId markerId = MarkerId('4544');
      final Marker marker = Marker(
        markerId: markerId,
        position: widget.latLng!,
        icon: _mapPinIcon!,
      );
      markers[markerId] = marker;
    }
    return (widget.latLng != null)
        ? ClipRRect(
            borderRadius: widget.borderRadius ?? BorderRadius.zero,
            child: IgnorePointer(
                child: GoogleMap(
                    liteModeEnabled: true,
                    onMapCreated: _onMapCreated,
                    myLocationButtonEnabled: false,
                    compassEnabled: false,
                    trafficEnabled: false,
                    zoomControlsEnabled: false,
                    tiltGesturesEnabled: false,
                    buildingsEnabled: false,
                    mapToolbarEnabled: false,
                    indoorViewEnabled: false,
                    myLocationEnabled: false,
                    zoomGesturesEnabled: false,
                    rotateGesturesEnabled: false,
                    scrollGesturesEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.latLng!.latitude + 0.0004,
                          widget.latLng!.longitude),
                      zoom: 14,
                    ),
                    markers: Set<Marker>.of(markers.values))),
          )
        : const SizedBox();
  }
}
