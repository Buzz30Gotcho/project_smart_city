import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:proximity/config/themes/google_map_theme.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoder;
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/store_repository/src/policy_creation_validation.dart';
//import 'package:proximity_commercant/domain/store_repository/src/store_creation_validation.dart';
import 'package:proximity_commercant/domain/store_repository/src/store_service.dart';

class AreaSelectionScreen extends StatefulWidget {
  const AreaSelectionScreen(
      {Key? key, required this.currentAddress, this.ShippingMaxKm})
      : super(key: key);

  final Address currentAddress;
  final double? ShippingMaxKm;

  @override
  _AreaSelectionScreenState createState() => _AreaSelectionScreenState();
}

class _AreaSelectionScreenState extends State<AreaSelectionScreen> {
  double _counter = 30;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter += 10;
    });
  }

  final Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  TextEditingController _counterController = TextEditingController();

  // selected address and location
  Address? selectedAddress;
  late LatLng selectedLocation;
  late LatLng selectedLocation0;
  late LatLng selectedLocation1;

  // initial camera location
  LatLng? initialCameraLocation;
  double? initialZoom;

  // current country lo
  late LatLng franceLocation;

  /// This method is used to create the google map
  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle((Theme.of(context).brightness == Brightness.dark)
        ? GoogleMapsThemes.darkTheme
        : GoogleMapsThemes.lightTheme);
    _controller.complete(controller);
  }

  /// This method is used to localise the client app
  Future<Position?> getUserLocation() async {
    //Position location;
    String error;
    try {
      return await Geolocator.getCurrentPosition();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        print(error);
      }
      return null;
    }
  }

  /// This method is retrieve the address of a given location (lat, long)
  Future<Address> getLocationAddress(LatLng latLng) async {
    var addresses = await geocoder.placemarkFromCoordinates(
        latLng.latitude, latLng.longitude);
    var address = addresses.first;
    return Address(
      lat: latLng.latitude,
      lng: latLng.longitude,
      countryName: address.country,
      countryCode: address.isoCountryCode,
      locality: address.subAdministrativeArea,
      region: address.administrativeArea,
      city: address.locality,
      fullAddress: address.street,
      streetName: address.street,
      postalCode: address.postalCode,
    );
  }

  @override
  void initState() {
    super.initState();
    _counterController.text = _counter.toString();
    franceLocation = const LatLng(46.2276, 2.2137);
    if (widget.currentAddress.isAddressValid) {
      setState(() {
        /// set selected address
        selectedAddress = widget.currentAddress;

        /// set selected location
        selectedLocation =
            LatLng(widget.currentAddress.lat!, widget.currentAddress.lng!);

        /// set initial Zoom and Camera Location
        initialCameraLocation = selectedLocation;
        initialZoom = 12.0;

        /// Initialize Marker
        const MarkerId markerId = MarkerId('4544');
        final Marker marker = Marker(
          markerId: markerId,
          position: selectedLocation,
        );
        markers[markerId] = marker;
      });
    } else {
      selectedLocation = franceLocation;
      initialCameraLocation = selectedLocation;
      getUserLocation().then((Position? locationData) => setState(() {
            initialCameraLocation =
                LatLng(locationData!.latitude, locationData.longitude);
            selectedLocation = initialCameraLocation!;
            initialZoom = 12.0;
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    getUserLocation();
    return ChangeNotifierProvider<PolicyValidation>(
        create: (context) => PolicyValidation(), //.setStore(store),
        child: Consumer2<PolicyValidation, StoreService>(
            builder: (context, policyValidation, storeService, child) {
          return Scaffold(
              body: Stack(children: [
            Expanded(
                child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    myLocationButtonEnabled: false,
                    compassEnabled: true,
                    trafficEnabled: false,
                    zoomControlsEnabled: false,
                    tiltGesturesEnabled: false,
                    initialCameraPosition: CameraPosition(
                        target: initialCameraLocation ?? franceLocation,
                        zoom: initialZoom ?? 5.0),
                    markers: Set<Marker>.of(markers.values),
                    circles: {
                      Circle(
                          circleId: CircleId("circle"),
                          center: selectedLocation,
                          //LatLng(48.35250847104775, 2.31860239058733),
                          radius: policyValidation.shippingMaxKM * 1000,
                          fillColor: Colors.blue.withOpacity(0.5),
                          strokeColor: Colors.blue,
                          strokeWidth: 2)
                    },
                    onTap: (LatLng latLng) {
                      // creating a new MARKER
                      const MarkerId markerId = MarkerId('4544');
                      final Marker marker =
                          Marker(markerId: markerId, position: latLng);
                      selectedLocation = latLng;
                      getLocationAddress(latLng).then((address) {
                        setState(() {
                          selectedAddress = address;
                          markers.clear();
                          // adding a new marker to map
                          markers[markerId] = marker;
                        });
                      });
                    })),
            Container(
                padding: const EdgeInsets.symmetric(vertical: normal_100),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).backgroundColor,
                  Theme.of(context).backgroundColor.withOpacity(0.0),
                ], begin: Alignment.center, end: Alignment.bottomCenter)),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TopBar(title: 'Select a shipping area '),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: normal_100),
                          child: Text(
                              (selectedAddress != null)
                                  ? selectedAddress!.getAddressLine
                                  : "Please Select an Address",
                              style: Theme.of(context).textTheme.subtitle2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis))
                    ])),
            Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //TimeButton(onPressed: null, text: Text('$_counter')),
                        SmallIconButton(
                          icon: Icon(Icons.minimize_outlined),
                          onPressed: policyValidation.decShippingMaxKM,
                        ),
                        SizedBox(
                          width: 200,
                          height: 60,
                          child: TimeButton(
                            onPressed: policyValidation.incrShippingMaxKM,
                            text: Text(
                                policyValidation.shippingMaxKM.toString() +
                                    "  KM"),
                          ),
                          /* child: TextField(
                          controller: _counterController,
                          /* hint: 'Number of Km',

                          borderType: BorderType.top,
                          saved: _counter.toString(),*/
                          //errorText: policyValidation.storeName.error,
                          enabled: true,
                          //   onChanged: _incrementCounter,
                        ),*/
                        ),

                        //TimeButton(onPressed: null, text: Text('$_counter')),
                        SmallIconButton(
                          icon: Icon(Icons.add),
                          onPressed: policyValidation.incrShippingMaxKM,
                        ),
                      ],
                    ),
                    BottomActionsBar(buttons: [
                      PrimaryButton(
                          title: 'Validate.',
                          onPressed: selectedAddress != null
                              ? () {
                                  Navigator.pop(context, selectedAddress);
                                }
                              : null)
                    ]),
                  ],
                ))
          ]));
        }));
  }
}
