import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/ui/pages/store_pages/store_pages.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';

class StoreMap extends StatefulWidget {
  StoreMap({Key? key, required this.address, this.store, this.index})
      : super(key: key);

  Store? store;
  int? index;
  final Address address;

  @override
  State<StoreMap> createState() => _StoreMapState();
}

class _StoreMapState extends State<StoreMap> {
  @override
  Widget build(BuildContext context) {
    /// calculate card height to avoid PageView overflow
    double _screenWidth = MediaQuery.of(context).size.width;
    double _cardImageWidth = _screenWidth - (small_100 + tiny_50) * 2;
    double _cardImageHeight = _cardImageWidth * 8 / 11;
    Store? store = widget.store;
    int? index = widget.index;
    Address address = widget.address;

    return Card(
        margin: const EdgeInsets.all(small_100).copyWith(bottom: 0),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Theme.of(context).dividerColor, width: tiny_50),
            borderRadius: const BorderRadius.all(normalRadius)),
        child: SizedBox(
            width: _cardImageWidth,
            height: _cardImageHeight,
            child: Stack(children: [
              GoogleMapsAddress(
                  borderRadius: const BorderRadius.all(normalRadius),
                  latLng: LatLng(address.lat!, address.lng!)),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      width: double.infinity,
                      color:
                          Theme.of(context).backgroundColor.withOpacity(2 / 3),
                      padding: const EdgeInsets.all(small_100)
                          .copyWith(right: huge_100),
                      child: Text(address.getAddressLine,
                          style: Theme.of(context).textTheme.bodyText1))),

              /// Top Buttons
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: small_100, vertical: normal_100),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallIconButton(
                            onPressed: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                            icon: const Icon(ProximityIcons.chevron_left)),
                        SmallIconButton(
                            onPressed: () {
                              showMenu(
                                context: context,
                                surfaceTintColor:
                                    Theme.of(context).dividerColor,
                                color: Colors.white.withOpacity(0.9),
                                position: RelativeRect.fromLTRB(50, 0, 50, 0),
                                items: [
                                  PopupMenuItem(
                                    child: Column(
                                      children: [
                                        Text("Edit Global informations",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0))),
                                      ],
                                    ),
                                    value: 1,
                                  ),
                                  PopupMenuItem(
                                    child: Column(
                                      children: [
                                        Text("Edit Store Categories",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0))),
                                      ],
                                    ),
                                    value: 2,
                                  ),
                                  PopupMenuItem(
                                    child: Column(
                                      children: [
                                        Text("Edit Product Categories",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0))),
                                      ],
                                    ),
                                    value: 3,
                                  ),
                                  PopupMenuItem(
                                    child: Column(
                                      children: [
                                        Text("Edit Store Rayons",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0))),
                                      ],
                                    ),
                                    value: 4,
                                  ),
                                  PopupMenuItem(
                                    child: Column(
                                      children: [
                                        Text("Edit Store Template",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0))),
                                      ],
                                    ),
                                    value: 5,
                                  ),
                                ],
                                elevation: 4.0,
                              ).then((value) {
                                // Handle the selected option here
                                if (value == 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StoreEditScreen(
                                                index: index,
                                                store: store!,
                                                editScreen: true,
                                              )));
                                } else if (value == 2) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StoreEditStoreCategoriesScreen(
                                                index: index,
                                                store: store!,
                                              )));
                                } else if (value == 3) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StoreEditProductCategoriesScreen(
                                                index: index,
                                                store: store!,
                                              )));
                                } else if (value == 4) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StoreEditStoreRayonsScreen(
                                                index: index,
                                                store: store!,
                                              )));
                                } else if (value == 5) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StoreEditStoreTemplateScreen(
                                                index: index,
                                                store: store!,
                                              )));
                                }
                              });
                              // if (Navigator.canPop(context)) {
                              //   Navigator.pop(context);
                              // }
                            },
                            icon: const Icon(ProximityIcons.more))
                      ])),
            ])));
  }
}
