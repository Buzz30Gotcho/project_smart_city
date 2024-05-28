import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proximity/proximity.dart';

class StoreMap extends StatelessWidget {
  const StoreMap({Key? key, required this.address}) : super(key: key);

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
            margin: const EdgeInsets.all(small_100).copyWith(bottom: 0),
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: dividerDarkColor, width: tiny_50),
                borderRadius: BorderRadius.all(normalRadius)),
            child: SizedBox(
                height: huge_300,
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  GoogleMapsAddress(
                      borderRadius: const BorderRadius.all(normalRadius),
                      latLng: LatLng(address.lat!, address.lng!)),
                  Container(
                      width: double.infinity,
                      color:
                          Theme.of(context).colorScheme.background.withOpacity(2 / 3),
                      padding: const EdgeInsets.all(small_100)
                          .copyWith(right: huge_100),
                      child: Text(address.streetName ?? '',
                          style: Theme.of(context).textTheme.bodyLarge))
                ]))),

        /// Top Buttons
        Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: normal_100, vertical: normal_200),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallIconButton(
                      onPressed: () {
                        if (Navigator.canPop(context)) Navigator.pop(context);
                      },
                      icon: const Icon(ProximityIcons.chevron_left)),
                  SmallIconButton(
                      onPressed: () {
                        if (Navigator.canPop(context)) Navigator.pop(context);
                      },
                      icon: const Icon(ProximityIcons.more))
                ])),
      ],
    );
  }
}
