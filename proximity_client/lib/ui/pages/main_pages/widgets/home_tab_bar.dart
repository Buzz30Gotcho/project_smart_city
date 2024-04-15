
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/data_persistence/src/boxes.dart';
import 'package:proximity_client/domain/notification_repository/notification_repository.dart';
import 'package:proximity_client/domain/user_repository/models/address_item_model.dart';
import 'package:proximity_client/ui/widgets/address_picker/address_selection_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';



class HomeTabBar extends StatefulWidget {
  const HomeTabBar({Key? key}) : super(key: key);

  @override
  State<HomeTabBar> createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> {
  String? _currentAddress;
  Position? _currentPosition;
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      //todo : A complete
      AddressItem address = AddressItem(
          lat: position.latitude,
          lng: position.longitude,
          streetName: place.street,
          city: place.locality,
          postalCode: place.postalCode);
      setState(() {
        _currentAddress = '${place.street}, ${place.locality}';
        var credentialsBox = Boxes.getCredentials();
        credentialsBox.put('address', address);
        print('ade_getAddressFromLatLng${_currentAddress!}');
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    final credentialsBox = Boxes.getCredentials();
    AddressItem? userAddress = credentialsBox.get('address');

    if (userAddress != null) {
      setState(() {
        _currentAddress = '${userAddress.streetName!},${userAddress.city!}';
      });
    } else {
      // Retrieve the current position and address
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        _currentPosition = position;
        _getAddressFromLatLng(_currentPosition!);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
            padding: const EdgeInsets.all(normal_100),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /* Icon(Icons.pin_drop_outlined,
                      color: Theme.of(context)
                          .primaryColor), //hoverColor, size: normal_100),
                  */
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressSelectionScreen(
                                    currentAddress: Address(),
                                    navigation: true,
                                  )));
                      setState(() {
                        _currentAddress = result;
                        print('aderesult$_currentAddress');
                      });
                    },
                    /*  print("""/////""" + _result);
                              print(AddressItem.fromAdress(_result));,*/
                    child: Row(
                      children: [
                        const SizedBox(width: small_50),
                        _currentAddress != null
                            ? Text(_currentAddress!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: primaryTextLightColor))
                            : ShimmerFx(
                                child: Container(
                                    color: Theme.of(context).cardColor,
                                    child: Text('Montpellier, France',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium))),
                        const Icon(ProximityIcons.chevron_bottom),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Consumer<NotificationService>(
                      builder: (_, notificationService, __) {
                    var nbNotifs = notificationService.notifications
                        .where((element) => element.seendInList != true)
                        .length;
                    return Stack(children: [
                      SmallIconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             const NotificationsScreen()));
                            notificationService.makeItListSeend();
                            notificationService.getNotifications(context);
                          },
                          icon: const Icon(ProximityIcons.notifications)),
                      if (nbNotifs > 0)
                        Container(
                            padding: const EdgeInsets.all(tiny_50),
                            margin: const EdgeInsets.only(top: 0, left: 40),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(tinyRadius),
                                color: redSwatch.shade500),
                            child: Text(
                              '$nbNotifs',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: primaryTextDarkColor,
                                      fontWeight: FontWeight.w800),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ))
                    ]);
                  }),
                  const SizedBox(width: normal_100)
                ])),
      ],
    );
  }
}
