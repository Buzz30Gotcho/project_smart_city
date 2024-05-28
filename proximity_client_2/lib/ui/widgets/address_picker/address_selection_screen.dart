import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proximity/config/themes/google_map_theme.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

//import 'package:geocoding/geocoding.dart' as geocoder;
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';
import 'package:proximity_client/domain/user_repository/models/address_item_model.dart';
import 'package:proximity_client/ui/pages/main_pages/view/main_screen.dart';
import 'package:proximity_client/domain/data_persistence/src/boxes.dart';
import 'package:geolocator/geolocator.dart';

class AddressSelectionScreen extends StatefulWidget {
  const AddressSelectionScreen(
      {Key? key, required this.currentAddress, this.navigation})
      : super(key: key);

  final Address currentAddress;
  final bool? navigation;

  @override
  _AddressSelectionScreenState createState() => _AddressSelectionScreenState();
}

class _AddressSelectionScreenState extends State<AddressSelectionScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  // selected address and location
  Address? selectedAddress;
  late LatLng selectedLocation;

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
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle denied permission
      return null;
    }
    if (permission == LocationPermission.deniedForever) {
      // Handle permanently denied permission
      return null;
    }
    return await Geolocator.getCurrentPosition();
  }

  /// This method is retrieve the address of a given location (lat, long)
  Future<Address> getLocationAddress(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks.first;
    return Address(
      lat: position.latitude,
      lng: position.longitude,
      countryName: placemark.country,
      countryCode: placemark.isoCountryCode,
      locality: placemark.subAdministrativeArea,
      region: placemark.administrativeArea,
      city: placemark.locality,
      fullAddress: placemark.street,
      streetName: placemark.street,
      postalCode: placemark.postalCode,
    );
  }

  @override
  void initState() {
    super.initState();
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
      getUserLocation().then((Position? position) {
        if (position != null) {
          setState(() {
            initialCameraLocation =
                LatLng(position.latitude, position.longitude);
            selectedLocation = initialCameraLocation!;
            initialZoom = 12.0;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //getUserLocation();

    final productService = Provider.of<ProductService>(context);
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
            Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.background.withOpacity(0.0),
          ], begin: Alignment.center, end: Alignment.bottomCenter)),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopBar(title: 'Select an address'),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: normal_100),
                    child: Text(
                        (selectedAddress != null)
                            ? selectedAddress!.getAddressLine
                            : "Please Select an Address",
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis))
              ])),
      Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(normal_100),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: IconButton(
                        onPressed: () async {
                          Position? position = await getUserLocation();
                          LatLng latLng =
                              LatLng(position!.latitude, position.longitude);
                          selectedAddress = await getLocationAddress(latLng);

                          GoogleMapController controller =
                              await _controller.future;
                          controller.animateCamera(
                              CameraUpdate.newLatLngZoom(latLng, 12.0));

                          // Update the marker position
                          const MarkerId markerId = MarkerId('4544');
                          final Marker marker = Marker(
                            markerId: markerId,
                            position: latLng,
                          );
                          setState(() {
                            markers.clear();
                            markers[markerId] = marker;
                            selectedLocation = latLng;
                          });
                        },
                        icon: Icon(
                          Icons.pin_drop_outlined,
                          color: blueSwatch.shade500,
                        ),
                      ),
                      /*IconButton(
                        onPressed: () async {
                          Position? position = await getUserLocation();
                          LatLng latLng =
                              LatLng(position!.latitude, position!.longitude);
                          selectedAddress = await getLocationAddress(latLng);
                        },
                        icon: Icon(
                          Icons.pin_drop_outlined,
                          color: blueSwatch.shade500,
                        ),
                      ),*/
                    ),
                  ),
                ],
              ),
              BottomActionsBar(buttons: [
                PrimaryButton(
                    title: 'Validate.',
                    onPressed: selectedAddress != null
                        ? () {
                            if (widget.navigation == null) {
                              Navigator.pop(context, selectedAddress);
                            } else {
                              AddressItem addressItem = AddressItem(
                                  lat: selectedAddress!.lat,
                                  lng: selectedAddress!.lng,
                                  streetName: selectedAddress!.streetName,
                                  city: selectedAddress!.city,
                                  postalCode: selectedAddress!.postalCode,
                                  countryCode: selectedAddress!.countryCode,
                                  countryName: selectedAddress!.countryName,
                                  fullAddress: selectedAddress!.fullAddress,
                                  locality: selectedAddress!.locality,
                                  region: selectedAddress!.region);

                              //print(json.encode(addresse));
                              var credentialsBox = Boxes.getCredentials();
                              credentialsBox.put('address', addressItem);
                              productService.getProximityProducts();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const MainScreen(),
                                  ),
                                  (Route<dynamic> route) => false);
                            }
                          }
                        : null)
              ]),
            ],
          ))
    ]));
  }
}
